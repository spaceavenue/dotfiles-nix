{
  system.autoUpgrade = {
    enable = true;
    flake = "/home/sanya/.config/nixos#nyx";
    operation = "switch";
    dates = "Mon 03:00";
    randomizedDelaySec = "30min";
    persistent = true;
    allowReboot = false;
  };
}
