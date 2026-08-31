{ config, pkgs, ... }:

{
  import 
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    firefox-nightly-bin
    rusty-wl-utils
    rustclip
    dump-bgra
    fnott
    udiskrs
    xdg-user-dirs
    adw-gtk3
    bibata-cursors
    obsidian
    vesktop
    signal-desktop-custom
    prismlauncher
    qbittorrent
    nicotine-plus
    keepassxc
    syncthing
    zed-editor
    nautilus
    cava
    rmpc
    beets
  ];

  services.pipewire.enable = true;

  systemd.user.services = {
    fnott = {
      Unit = {
        Description = "Fnott notification daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
        Requisite = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.fnott}/bin/fnott";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    udiskrs = {
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

    cliphist = {
      Unit = {
        Description = "Wayland clipboard manager with support for multimedia";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
        Requisite = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.rustclip}/bin/wl-watch cliphist store";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    mpd = {
      Unit = {
        Description = "Music Player Daemon";
        After = [ "network.target" "sound.target" ];
        Requires = [ "mpd.socket" ];
      };
      Service = {
        Type = "notify";
        ExecStart = "${pkgs.mpd}/bin/mpd --systemd %h/.config/mpd/mpd.conf";
        Environment = "XDG_MUSIC_DIR=%h/msc";
      };
    };

    xdg-user-dirs-update = {
      Unit = {
        Description = "User folders update";
        Before = "graphical-session-pre.target";
      };
      Service = {
      Type = "oneshot";
        ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
      };
      Install.WantedBy = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.sockets.mpd = {
    Unit.Description = "Music Player Daemon Socket";
    Socket = {
      ListenStream = "127.0.0.1:6600";
    };
    Install.WantedBy = [ "sockets.target" ];
  };
}
