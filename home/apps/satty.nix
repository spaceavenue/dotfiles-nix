{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.satty ];

  xdg.configFile."satty/config.toml".source =
    formats.toml.generate "satty-config.toml" (import ./satty-data.nix);
}
