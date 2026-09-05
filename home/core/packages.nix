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
    # drop libkeepassxc-autotype-xcb.so, which opens a raw xcb connection
    # spawning xwayland-satellite on every login. no auto-type, whatever.
    (keepassxc.override { withKeePassX11 = false; })
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
  # nix-community nix-index-database flake, which is updated weekly.
  # the home-manager module overrides `programs.nix-index.package` to a
  # wrapper bundling that database and symlinks it into ~/.cache/nix-index/files.
  # updated by the weekly `nix flake update` timer (home/core/auto-update.nix).
  programs.nix-index.enable = true;
}
