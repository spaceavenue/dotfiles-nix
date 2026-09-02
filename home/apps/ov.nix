{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.ov ];

  xdg.configFile."ov/config.yaml".source = formats.yaml.generate "ov-config.yaml" (
    import ./ov-data.nix
  );
}
