{ pkgs, ... }:

{
  fonts.enableDefaultPackages = false;
  fonts.packages = [
    pkgs.ttf-ibm-plex-custom
    pkgs.ttc-iosevka-collection
    pkgs.nerd-fonts.symbols-only
    pkgs.twitter-color-emoji
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
