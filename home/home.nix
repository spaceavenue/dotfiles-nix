{ config, pkgs, ... }:

{
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
    helix
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
 
  xdg.configFile = {
    # Stage 2: configs edited often enough that a rebuild-per-change would be
    # annoying — symlinked to the live files in ./dotfiles/ via
    # mkOutOfStoreSymlink instead of copied into the store, so edits land
    # immediately and are just a `git commit` away, no rebuild needed. See
    # chat, 2026-09-01.
    "niri".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/niri";
    "fish".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/fish";
    "helix".source  = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/helix";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/waybar";
    "yazi".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/yazi";

    # Stage 1: static configs, rarely touched — plain store copies.
    "wgetrc".source = ./dotfiles/wgetrc;
    "user-dirs.dirs".source = ./dotfiles/user-dirs.dirs;
    "ripgrep/config".source = ./dotfiles/ripgrep/config;
    "ov/config.yaml".source = ./dotfiles/ov/config.yaml;
    "satty/config.toml".source = ./dotfiles/satty/config.toml;
    "swaylock/config".source = ./dotfiles/swaylock/config;
    "fnott/fnott.ini".source = ./dotfiles/fnott/fnott.ini;

    "electron-flags.conf".source = ./dotfiles/electron-flags.conf;
    "signal-desktop-flags.conf".source = ./dotfiles/electron-flags.conf;
    "vesktop-flags.conf".source = ./dotfiles/electron-flags.conf;
    "obsidian/user-flags.conf".source = ./dotfiles/electron-flags.conf;
  };
}
