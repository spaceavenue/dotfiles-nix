{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  xdg.configFile."npm/npmrc".source = formats.keyValue.generate "npmrc" (import ./npm-data.nix);
}
