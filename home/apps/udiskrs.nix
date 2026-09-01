{ pkgs, ... }:

{
  home.packages = [ pkgs.udiskrs ];

  systemd.user.services.udiskrs = {
    Unit = {
      Description = "udiskrs automount daemon";
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.udiskrs}/bin/udiskrs auto";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."udiskrs/mounts.conf".text = ''
    61d36ac1-d443-472b-8f5c-e90a6dc312ae rw,noatime,compress=zstd:3,ssd,discard=async,space_cache=v2,subvol=/@backup
  '';
}
