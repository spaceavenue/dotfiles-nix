{ pkgs, lib, ... }:

let
  formats = import ../../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.waybar ];

  xdg.configFile = {
    "waybar/config".source = formats.json.generate "waybar-config.json" (import ./config.nix);
    "waybar/style.css".text = import ./style.nix;

    "waybar/scripts/memory.sh" = {
      text = import ./memory-script.nix;
      executable = true;
    };
    "waybar/scripts/weather.sh" = {
      text = import ./weather-script.nix;
      executable = true;
    };
  };
}
