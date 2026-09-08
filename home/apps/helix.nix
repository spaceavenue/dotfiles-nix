{ config, pkgs, ... }:

{
  home.packages = [ pkgs.helix-custom ];

  xdg.configFile."helix".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/helix";
}
