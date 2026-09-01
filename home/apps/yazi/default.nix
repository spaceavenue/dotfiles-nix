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
    "yazi/package.toml".source = formats.toml.generate "yazi-package.toml" (import ./package.nix);
    "yazi/init.lua".text = import ./init.nix;
    "yazi/plugins".source = ../../dotfiles/yazi/plugins;
  };
}
