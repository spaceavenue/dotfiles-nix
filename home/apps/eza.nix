{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.eza ];

  xdg.configFile."eza/theme.yml".source =
    formats.yaml.generate "eza-theme.yml" (import ./eza-theme-data.nix);
}
