# Services with no single app. Everything else's systemd unit lives in its own app module
# (mpd's service in apps/mpd.nix, ...).
{ pkgs, ... }:

{
  services.pipewire.enable = true;

  home.packages = [ pkgs.rustclip pkgs.cliphist ];

  systemd.user.services.cliphist = {
    Unit = {
      Description = "Wayland clipboard manager";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.rustclip}/bin/wl-watch cliphist store";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
