{ pkgs, ... }:

{
  home.packages = [ pkgs.bat ];

  xdg.configFile = {
    "bat/themes/Theme.tmTheme".text = import ./bat-theme-data.nix;
    "bat/config".text = ''
      --theme="Theme"
      --italic-text=always
      --paging=never
    '';
  };
}
