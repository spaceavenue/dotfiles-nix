# Periodic self-update for the flake: bump inputs, regenerates the build-std
# Cargo.lock files, auto-patches stale fixed-output-derivation hashes
# anywhere under pkgs/ - see pkgs/auto-update.py.
{ config, pkgs, ... }:

let
  repoRoot = "${config.home.homeDirectory}/.config/nixos";
in
{
  systemd.user.services.nix-auto-update = {
    Unit.Description = "nix flake update + Cargo.lock/hash update";
    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "nix-auto-update" ''
        set -uo pipefail
        export PATH="${pkgs.git}/bin:${pkgs.nix}/bin:${pkgs.python3}/bin:$PATH"

        if ${repoRoot}/pkgs/auto-update.py; then
          if ${pkgs.git}/bin/git -C ${repoRoot} diff --quiet; then
            ${pkgs.libnotify}/bin/notify-send "nix flake update" "But nothing happened." || true
          else
            ${pkgs.libnotify}/bin/notify-send "nix flake update" "Update finished!" || true
          fi
        else
          ${pkgs.libnotify}/bin/notify-send -u critical "nix flake update failed :(" "journalctl --user -u nix-auto-update for details" || true
          exit 1
        fi
      '';
    };
  };

  systemd.user.timers.nix-auto-update = {
    Unit.Description = "Weekly nix flake update.";
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
