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
    (prismlauncher.override { jdks = [ jdk25 ]; })
    qbittorrent
    nicotine-plus
    keepassxc
    nautilus
    claude-code
    duf
    dust
    fd
    fzf
    glow
    hyperfine
    kid3
    libqalculate
    ouch
    oxipng
    pavucontrol
    exiftool
    playerctl
    powertop
    rustup
    sd
    trash-cli
    umu-launcher
    zoxide
    imv-custom
    wtype-custom
    swaylock-time
    niri-custom
    qoz
  ];

# prebuilt file->package index for fast lookups via nix-locate. pulls the
# nix-community nix-index-database flake, a prebuilt database updated weekly.
# the home-manager module (a `sharedModule` in flake.nix) overrides
# `programs.nix-index.package` to a wrapper bundling that database and symlinks
# it into ~/.cache/nix-index/files.
# update by the weekly `nix flake update` timer (home/core/auto-update.nix).
  programs.nix-index.enable = true;
}
