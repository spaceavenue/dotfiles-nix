{ config, pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
  settings = formats.ini.generate "gtk-settings.ini" (import ./gtk-settings-data.nix);
in
{
  xdg.configFile = {
    "gtk-3.0/settings.ini".source = settings;
    "gtk-4.0/settings.ini".source = settings;

    "gtk-3.0/gtk.css".text = import ./gtk3-css-data.nix;
    "gtk-4.0/gtk.css".text = import ./gtk4-css-data.nix;

    "gtk-3.0/bookmarks".source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.config/nixos/home/dotfiles/gtk/bookmarks";
  };
}
