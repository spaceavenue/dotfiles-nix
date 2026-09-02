{ pkgs, ... }:

{
  time.timeZone = "Asia/Kolkata";

  boot.blacklistedKernelModules = [ "sp5100-tco" ];

  documentation.man = {
    man-db.enable = false;
    mandoc.enable = true;
  };

  services = {
    speechd.enable = false;
    gnome.gnome-keyring.enable = false;
    udisks2.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - ${pkgs.bashInteractive}/bin/bash"
  ];

  system.stateVersion = "26.05";

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"

    ACTION=="add", SUBSYSTEM=="input", ATTR{name}=="TPPS/2 Elan TrackPoint", ATTR{device/sensitivity}="240", ATTR{device/press_to_select}="1"
  '';
}
