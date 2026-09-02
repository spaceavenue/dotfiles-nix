_:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = import ./config.nix;
    style = import ./style.nix;
    systemd.enable = true;
  };

  xdg.configFile = {
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
