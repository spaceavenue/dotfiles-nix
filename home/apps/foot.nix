{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.foot ];

  xdg.configFile = {
    "foot/foot.ini".source = formats.iniGlobal.generate "foot.ini" (import ./foot-data.nix);
    "foot/themes/catppuccin-mocha".source =
      formats.ini.generate "catppuccin-mocha" (import ./foot-theme-data.nix);
  };
}
