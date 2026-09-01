{ pkgs, ... }:

{
  home.packages = [ pkgs.rmpc ];

  xdg.configFile = {
    "rmpc/config.ron".text = import ./rmpc-config-data.nix;
    "rmpc/themes/main.ron".text = import ./rmpc-theme-data.nix;
  };
}
