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
    # syncthing
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
}
