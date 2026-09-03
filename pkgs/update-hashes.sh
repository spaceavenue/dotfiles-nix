#!/usr/bin/env bash
#
# Updater for stale fixed-output-derivation hashes
# (fetchFromGitHub `hash`, cargoDeps/cargoLock `outputHashes`, etc).
#
# Repeatedly builds $1 (a flake installable). On a `hash mismatch in
# fixed-output derivation` error, it string-replaces the stale hash with the one
# nix reports. Works for any package using this pattern.
#
# Stops the moment a build fails for a reason that isn't a hash mismatch.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="${1:-$repo_root#nixosConfigurations.nyx.config.system.build.toplevel}"
max_iters=10

for ((i = 1; i <= max_iters; i++)); do
  echo "== heal-hashes: build attempt $i/$max_iters =="
  if out="$(nix build --no-link --print-out-paths "$target" 2>&1)"; then
    echo "$out"
    echo "== heal-hashes: build succeeded =="
    exit 0
  fi

  echo "$out" >&2

  if ! grep -q "hash mismatch in fixed-output derivation" <<<"$out"; then
    echo "== heal-hashes: failure isn't a hash mismatch, giving up =="
    exit 1
  fi

  specified="$(grep -oP 'specified:\s*\K\S+' <<<"$out" | head -1)"
  got="$(grep -oP 'got:\s*\K\S+' <<<"$out" | head -1)"

  if [[ -z "$specified" || -z "$got" || "$specified" == "$got" ]]; then
    echo "== heal-hashes: couldn't parse specified/got hashes, giving up =="
    exit 1
  fi

  hits="$(grep -rl --include='*.nix' -F "$specified" "$repo_root" 2>/dev/null || true)"
  if [[ -z "$hits" ]]; then
    echo "== heal-hashes: hash '$specified' not found in any tracked .nix file, giving up =="
    exit 1
  fi

  echo "== heal-hashes: replacing $specified -> $got in: =="
  echo "$hits"
  while IFS= read -r file; do
    sed -i "s|$specified|$got|g" "$file"
  done <<<"$hits"
done

echo "== heal-hashes: gave up after $max_iters attempts :( =="
exit 1
