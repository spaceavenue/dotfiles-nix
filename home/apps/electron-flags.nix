{ pkgs, ... }:

let
  electronFlags = ''
    --enable-features=UseOzonePlatform,WaylandWindowDecorations,AllowQt,VaapiVideoDecoder,VaapiIgnoreDriverChecks
    --ozone-platform=wayland
    --password-store=gnome-libsecret
    --gtk-version=4
    --enable-unsafe-webgpu
  '';
in
{
  home.packages = with pkgs; [ obsidian vesktop signal-desktop-custom ];

  xdg.configFile = {
    "electron-flags.conf".text = electronFlags;
    "signal-desktop-flags.conf".text = electronFlags;
    "vesktop-flags.conf".text = electronFlags;
    "obsidian/user-flags.conf".text = electronFlags;
  };
}
