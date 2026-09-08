{ pkgs, ... }:
let
  xwayland-satellite_0_8_1 = pkgs.xwayland-satellite.overrideAttrs (old: rec {
    version = "0.8.1";
    src = pkgs.fetchFromGitHub {
      owner = "Supreeeme";
      repo = "xwayland-satellite";
      tag = "v${version}";
      hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
    };
    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit (old) pname;
      inherit version src;
      hash = "sha256-16L6gsvze+m7XCJlOA1lsPNELE3D364ef2FTdkh0rVY=";
    };
  });
in
{
  environment.systemPackages = with pkgs; [
    clang-mold
    efibootmgr
    ffmpeg
    ffmpegthumbnailer
    gnupg
    imagemagick
    libnotify
    mold
    ntfs3g
    openssh
    poppler-utils
    pinentry-curses
    python3
    smartmontools
    vulkan-tools
    wev
    xeyes
    xwayland-satellite_0_8_1
  ];

  programs.nix-ld.enable = true;
  programs.steam.enable = true;
}
