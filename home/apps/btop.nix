{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.btop ];

  xdg.configFile."btop/themes/main.theme".source =
    formats.keyValue.generate "main.theme" (import ./btop-theme-data.nix);
}
