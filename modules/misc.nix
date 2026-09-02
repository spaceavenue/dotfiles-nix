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
}
