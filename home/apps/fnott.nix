{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.fnott ];

  systemd.user.services.fnott = {
    Unit = {
      Description = "Fnott notification daemon";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.fnott}/bin/fnott";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."fnott/fnott.ini".source =
    formats.ini.generate "fnott.ini" (import ./fnott-data.nix);
}
