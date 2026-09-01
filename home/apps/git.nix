{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.config/nixos/home/dotfiles";
in
{
  home.packages = with pkgs; [ git github-cli delta lazygit ];

  xdg.configFile = {
    "git".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/git";
    "lazygit".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/lazygit";
    "gh/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/gh/config.yml";
  };
}
