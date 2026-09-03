#!/usr/bin/env bash
#
# Regenerate the checked-in Cargo.lock for the packages that build with `-Z build-std`.
# Those must contain the sysroot's own std/core/alloc dependency versions merged in and
# those drift every time the pinned fenix nightly updates.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# name -> "github repo:cargo --target triple:nix pkgs attr for the rustPlatform"
declare -A pkgs=(
  [rusty-wl-utils]="rusty-wl-utils:x86_64-unknown-linux-musl:rustNightlyMuslPlatform"
  [rustclip]="rustclip:x86_64-unknown-linux-musl:rustNightlyMuslPlatform"
  [dump-bgra]="dump-bgra:x86_64-unknown-linux-gnu:rustNightlyPlatform"
)

for name in "${!pkgs[@]}"; do
  IFS=: read -r repo target attr <<<"${pkgs[$name]}"

  echo "== $name (target $target, toolchain via pkgs.$attr) =="

  cargo_bin="$(nix build --no-link --print-out-paths \
    "$repo_root#nixosConfigurations.nyx.pkgs.$attr.cargo")/bin/cargo"
  rustc_bin="$(nix build --no-link --print-out-paths \
    "$repo_root#nixosConfigurations.nyx.pkgs.$attr.rustc")/bin/rustc"

  src="$work/$name"
  git clone --depth 1 "https://github.com/spaceavenue/$repo" "$src"

  (
    cd "$src"
    export RUSTC="$rustc_bin"
    export PATH="$(dirname "$rustc_bin"):$PATH"
    "$cargo_bin" check \
      -Z build-std=std,core,alloc,panic_abort \
      --target "$target"
  )

  cp "$src/Cargo.lock" "$repo_root/pkgs/$name/Cargo.lock"
  echo "== updated pkgs/$name/Cargo.lock !"
done

echo
echo "done! Run nix fmt . && nix flake check && nix build --no-link ..toplevel"
echo "if a build fails on a git-dependency hash mismatch, copy the 'got: sha256-...' hash"
echo "nix prints into the relevant default.nix's outputHashes."
