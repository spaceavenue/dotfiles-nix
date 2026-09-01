# Live-edit symlinks, like fish/niri/helix: config changes on disk take
# effect without a rebuild.
#
# git and lazygit each have exactly one file, so the whole directory is
# symlinked. gh is per-file instead: hosts.yml holds its host auth cache
# (app-written, and not something to put in git), so only config.yml is
# Nix-managed -- hosts.yml stays a real, untouched, untracked file
# alongside it (see .gitignore).
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
