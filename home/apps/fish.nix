{ config, ... }:

{
  xdg.configFile."fish".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/fish";
}
