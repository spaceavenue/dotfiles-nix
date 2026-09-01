{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.fuzzel ];

  xdg.configFile = {
    "fuzzel/fuzzel.ini".source =
      formats.iniGlobal.generate "fuzzel.ini" (import ./fuzzel-data.nix);
    "fuzzel/theme.ini".source =
      formats.ini.generate "fuzzel-theme.ini" (import ./fuzzel-theme-data.nix);
  };
}
