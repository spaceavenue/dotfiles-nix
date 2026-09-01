{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.xdg-user-dirs ];

  systemd.user.services.xdg-user-dirs-update = {
    Unit = {
      Description = "User folders update";
      Before = "graphical-session-pre.target";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
    };
    Install.WantedBy = [ "graphical-session-pre.target" ];
  };

  xdg.configFile."user-dirs.dirs".source =
    formats.keyValue.generate "user-dirs.dirs" (import ./user-dirs-data.nix);
}
