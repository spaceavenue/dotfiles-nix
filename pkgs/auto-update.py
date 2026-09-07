#!/usr/bin/env python3

"""Periodic self-update flow run via nix-auto-update.service/.timer
(home/core/auto-update.nix), or manually (w/ no args):

  1. bump all flake inputs
  2. regenerate the build-std Cargo.lock files (rusty-wl-utils, rustclip, dump-bgra)
     against the (possibly newer) fenix nightly
  3. bump any stale fixed-output-derivation hash anywhere in the repo
     (fetchFromGitHub `hash`, cargoLock `outputHashes`) against a toplevel build
  4. format, check, do verification build
  5. on success, commit the files that were touched

subcommands run one step in isolation (for debugging and stuff):
  auto-update.py rust-locks
  auto-update.py heal-hashes [flake installable, default: toplevel]
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from datetime import datetime
from functools import lru_cache
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TOPLEVEL_TARGET = f"{REPO_ROOT}#nixosConfigurations.nyx.config.system.build.toplevel"


def log(msg: str) -> None:
    print(f"[{datetime.now().astimezone().isoformat(timespec='seconds')}] {msg}", flush=True)


def run(cmd: list[str], **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, cwd=REPO_ROOT, **kwargs)


@lru_cache
def nix_build_out_path(installable: str) -> Path:
    # only stdout (the path) is captured, stderr still streams live. cached
    # since rusty-wl-utils and rustclip share a toolchain (rustNightlyMuslPlatform)
    # and all three targets share the same stdenv.cc - no need to rebuild/refetch twice.
    result = run(["nix", "build", "--no-link", "--print-out-paths", installable], stdout=subprocess.PIPE, text=True, check=True)
    return Path(result.stdout.strip().splitlines()[-1])


# Step 2: regenerate build-std Cargo.lock files

@dataclass
class RustLockTarget:
    name: str
    repo: str
    target: str
    rust_platform_attr: str


RUST_LOCK_TARGETS = [
    RustLockTarget("rusty-wl-utils", "rusty-wl-utils", "x86_64-unknown-linux-musl", "rustNightlyMuslPlatform"),
    RustLockTarget("rustclip", "rustclip", "x86_64-unknown-linux-musl", "rustNightlyMuslPlatform"),
    RustLockTarget("dump-bgra", "dump-bgra", "x86_64-unknown-linux-gnu", "rustNightlyPlatform"),
]

_PACKAGE_BLOCK_RE = re.compile(r"\n(?=\[\[package\]\])")
_NAME_RE = re.compile(r'^\[\[package\]\]\nname = "([^"]+)"')
_VERSION_RE = re.compile(r'^version = "([^"]+)"', re.MULTILINE)


def _parse_lock_blocks(text: str) -> tuple[str, list[tuple[str, str]]]:
    """split a Cargo.lock into (header, [(dedup_key, block_text), ...]),
    preserving order and dropping exact name+version duplicates."""
    header, *blocks = _PACKAGE_BLOCK_RE.split(text)
    seen: set[str] = set()
    ordered: list[tuple[str, str]] = []
    for block in blocks:
        name_match = _NAME_RE.match(block)
        version_match = _VERSION_RE.search(block)
        key = f"{name_match.group(1) if name_match else ''}\x1f{version_match.group(1) if version_match else ''}"
        if key not in seen:
            seen.add(key)
            ordered.append((key, block))
    return header, ordered


def merge_cargo_locks(project_lock: Path, library_lock: Path) -> None:
    """`cargo build -Z build-std` resolves std's own registry dependencies
    against rust-src's own library/Cargo.lock, but doesn't merge them into
    the project's Cargo.lock. Nix's vendor step needs them present in the
    single lockfile. so we merge rust-src's lock in here."""
    header, project_blocks = _parse_lock_blocks(project_lock.read_text())
    _, library_blocks = _parse_lock_blocks(library_lock.read_text())

    seen = {key for key, _ in project_blocks}
    merged = list(project_blocks)
    for key, block in library_blocks:
        if key not in seen:
            seen.add(key)
            merged.append((key, block))

    project_lock.write_text(header + "".join(block for _, block in merged))


def update_rust_locks() -> None:
    with tempfile.TemporaryDirectory() as work:
        for t in RUST_LOCK_TARGETS:
            log(f"== {t.name} (target {t.target}, toolchain via pkgs.{t.rust_platform_attr}) ==")

            cargo_bin = (
                nix_build_out_path(f"{REPO_ROOT}#nixosConfigurations.nyx.pkgs.{t.rust_platform_attr}.rust.cargo")
                / "bin"
                / "cargo"
            )
            rustc_bin = (
                nix_build_out_path(f"{REPO_ROOT}#nixosConfigurations.nyx.pkgs.{t.rust_platform_attr}.rust.rustc")
                / "bin"
                / "rustc"
            )
            # cc-rs (pulled in by crates like zstd-sys) needs a host cc/ar to
            # build their build scripts; the sandboxed toolchain above
            # doesn't provide one. `^out` avoids stdenv.cc's second "man"
            # output landing in the path instead.
            cc_bin = nix_build_out_path(f"{REPO_ROOT}#nixosConfigurations.nyx.pkgs.stdenv.cc^out") / "bin"

            src = Path(work) / t.name
            run(["git", "clone", "--depth", "1", f"https://github.com/spaceavenue/{t.repo}", str(src)], check=True)

            env = os.environ.copy()
            env["RUSTC"] = str(rustc_bin)
            env["PATH"] = f"{rustc_bin.parent}:{cc_bin}:{env['PATH']}"
            subprocess.run(
                [str(cargo_bin), "build", "-Z", "build-std=std,core,alloc,panic_abort", "--target", t.target],
                cwd=src,
                env=env,
                check=True,
            )

            sysroot_root = rustc_bin.parent.parent
            library_lock = sysroot_root / "lib" / "rustlib" / "src" / "rust" / "library" / "Cargo.lock"
            merge_cargo_locks(src / "Cargo.lock", library_lock)

            dest = REPO_ROOT / "pkgs" / t.name / "Cargo.lock"
            shutil.copy(src / "Cargo.lock", dest)
            log(f"== updated pkgs/{t.name}/Cargo.lock ! ==")


# Step 3: heal stale fixed-output-derivation hashes

_SPECIFIED_RE = re.compile(r"specified:\s*(\S+)")
_GOT_RE = re.compile(r"got:\s*(\S+)")


def heal_hashes(target: str, max_iters: int = 10) -> bool:
    """Repeatedly build `target`. On a `hash mismatch in fixed-output
    derivation` error, string-replaces the stale hash with the one nix
    reports, everywhere it appears under a tracked .nix file. Works for any
    package using this pattern (fetchFromGitHub `hash`, cargoLock
    `outputHashes`, etc). Stops when a build fails for a reason that
    isn't a hash mismatch."""
    for i in range(1, max_iters + 1):
        log(f"== heal-hashes: build attempt {i}/{max_iters} ==")
        result = run(
            ["nix", "build", "--no-link", "--print-out-paths", target],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        )
        out = result.stdout
        if result.returncode == 0:
            print(out, end="")
            log("== heal-hashes: build succeeded ==")
            return True

        print(out, end="", file=sys.stderr)

        if "hash mismatch in fixed-output derivation" not in out:
            log("== heal-hashes: failure isn't a hash mismatch, giving up ==")
            return False

        specified_match = _SPECIFIED_RE.search(out)
        got_match = _GOT_RE.search(out)
        specified = specified_match.group(1) if specified_match else None
        got = got_match.group(1) if got_match else None

        if not specified or not got or specified == got:
            log("== heal-hashes: couldn't parse specified/got hashes, giving up ==")
            return False

        hits = [p for p in REPO_ROOT.rglob("*.nix") if specified in p.read_text(errors="ignore")]
        if not hits:
            log(f"== heal-hashes: hash '{specified}' not found in any tracked .nix file, giving up ==")
            return False

        log(f"== heal-hashes: replacing {specified} -> {got} in: ==")
        for f in hits:
            log(str(f.relative_to(REPO_ROOT)))
            f.write_text(f.read_text().replace(specified, got))
            run(["git", "add", "--", str(f)], check=True)

    log(f"== heal-hashes: gave up after {max_iters} attempts :( ==")
    return False


# Full flow

def main_all() -> int:
    log("updating flake inputs...")
    if run(["nix", "flake", "update"]).returncode != 0:
        log("flake update failed")
        return 1

    log("regenerating build-std Cargo.lock files...")
    try:
        update_rust_locks()
    except subprocess.CalledProcessError:
        log("update-rust-locks failed")
        return 1

    log("bumping stale fixed-output-derivation hashes...")
    if not heal_hashes(TOPLEVEL_TARGET):
        log("heal-hashes failed or hit a non-hash break")
        return 1

    log("running nix fmt...")
    if run(["nix", "fmt", "."]).returncode != 0:
        log("nix fmt reported issues. non-fatal, continuing")

    log("running nix flake check...")
    if run(["nix", "flake", "check"]).returncode != 0:
        log("nix flake check failed")
        return 1

    log("final verification build...")
    if run(["nix", "build", "--no-link", "--print-out-paths", TOPLEVEL_TARGET]).returncode != 0:
        log("final verification build failed")
        return 1

    log("staging update-produced files...")
    lock_files = [str(p) for p in sorted(REPO_ROOT.glob("pkgs/*/Cargo.lock"))]
    run(["git", "add", "--", "flake.lock", *lock_files], check=True)

    if run(["git", "diff", "--cached", "--quiet"]).returncode == 0:
        log("no changes produced.")
    else:
        timestamp = datetime.now().astimezone().isoformat(timespec="seconds")
        message = f"auto-update: flake inputs, build-std lockfiles + FOD hash update\n\n{timestamp}"
        run(["git", "commit", "-m", message], check=True, stdout=subprocess.DEVNULL)
        log("done! committed:")
        run(["git", "show", "--stat", "--format="], check=True)

    if run(["git", "diff", "--quiet"]).returncode != 0:
        log("note: working tree still has unrelated uncommitted changes:")
        run(["git", "status", "--short"], check=True)

    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command")
    sub.add_parser("rust-locks", help="only regenerate the build-std Cargo.lock files")
    heal_parser = sub.add_parser("heal-hashes", help="only heal stale fixed-output-derivation hashes")
    heal_parser.add_argument("target", nargs="?", default=TOPLEVEL_TARGET)
    args = parser.parse_args()

    if args.command == "rust-locks":
        try:
            update_rust_locks()
        except subprocess.CalledProcessError:
            return 1
        return 0
    if args.command == "heal-hashes":
        return 0 if heal_hashes(args.target) else 1
    return main_all()


if __name__ == "__main__":
    sys.exit(main())
