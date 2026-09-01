# Packages that aren't tied to any single app module below. App-specific packages live with their
# app under home/apps/
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox-nightly-bin
    rusty-wl-utils
    dump-bgra
    adw-gtk3
    bibata-cursors
    prismlauncher
    qbittorrent
    nicotine-plus
    keepassxc
    syncthing
    nautilus
  ];
}
