# yazi/package.toml and yazi/plugins are deliberately NOT managed here:
# yazi's own package manager (`ya pkg install` / `ya pkg add`) owns both --
# it fetches plugins from their upstream repos and rewrites package.toml
# with what it fetched, which conflicts with a read-only Nix-generated file.
# After a fresh deploy, run `ya pkg install` once to populate plugins/.
{ pkgs, lib, ... }:

let
  formats = import ../../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.yazi ];

  xdg.configFile = {
    "yazi/yazi.toml".source = formats.toml.generate "yazi.toml" (import ./yazi.nix);
    "yazi/theme.toml".source = formats.toml.generate "yazi-theme.toml" (import ./theme.nix);
    "yazi/keymap.toml".source = formats.toml.generate "yazi-keymap.toml" (import ./keymap.nix);
    "yazi/init.lua".text = import ./init.nix;
  };
}
