{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.zed-editor ];

  xdg.configFile."zed/themes/theme.json".source =
    formats.json.generate "theme.json" (import ./zed-theme-data.nix);
}
