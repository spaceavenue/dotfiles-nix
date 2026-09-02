{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang-mold
    efibootmgr
    ffmpeg
    ffmpegthumbnailer
    gnupg
    imagemagick
    libnotify
    make
    mold
    # niri-custom
    ntfs3g
    openssh
    pinentry-curses
    smartmontools
    ttf-ibm-plex-custom
    ttc-iosevka-collection
    vulkan-tools
    wev
    xeyes
    xwayland-satellite
  ];
}
