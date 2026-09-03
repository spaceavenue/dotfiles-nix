#!/usr/bin/env bash
# Run the hash update flow periodically using nix-auto-update.service/.timer (see home/core/auto-update.nix):
#   1. bump all flake inputs
#   2. regenerate build-std Cargo.lock files (rusty-wl-utils, dump-bgra, rustclip)
#      against the (possibly newer) fenix nightly
#   3. bump any stale fixed-output-derivation hash anywhere in the repo
#      (fetchFromGitHub `hash`, cargoLock `outputHashes`) against a toplevel build
#   4. format + flake-check + one last verification build
set -uo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

log() { echo "[$(date -Iseconds)] $*"; }

log "updating flake inputs..."
if ! nix flake update; then
  log "flake update failed"
  exit 1
fi

log "regenerating build-std Cargo.lock files..."
if ! "$repo_root/pkgs/update-rust-locks.sh"; then
  log "update-rust-locks.sh failed"
  exit 1
fi

log "bumping stale fixed-output-derivation hashes..."
if ! "$repo_root/pkgs/update-hashes.sh" "$repo_root#nixosConfigurations.nyx.config.system.build.toplevel"; then
  log "update-hashes.sh failed or hit a non-hash break"
  exit 1
fi

log "running nix fmt..."
nix fmt . || log "nix fmt reported issues. non-fatal, continuing"

log "running nix flake check..."
if ! nix flake check; then
  log "nix flake check failed"
  exit 1
fi

log "final verification build..."
if ! nix build --no-link --print-out-paths "$repo_root#nixosConfigurations.nyx.config.system.build.toplevel"; then
  log "final verification build failed"
  exit 1
fi

if git diff --quiet && git diff --cached --quiet; then
  log "no changes produced."
else
  log "done!"
  git status --short
fi
