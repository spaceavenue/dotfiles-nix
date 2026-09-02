{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.cava ];

  xdg.configFile."cava/config".source = formats.ini.generate "cava-config" (import ./cava-data.nix);
}
