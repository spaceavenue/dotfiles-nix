{ config, pkgs, ... }:

{
  home.packages = [ pkgs.helix ];

  xdg.configFile."helix".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/helix";
}
