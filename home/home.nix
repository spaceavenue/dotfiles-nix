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
    "niri".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/niri";
    "fish".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/fish";
    "helix".source  = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/helix";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/waybar";
    "yazi".source   = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/home/dotfiles/yazi";

    "bat".source = ./dotfiles/bat;
    "cava".source = ./dotfiles/cava;
    "clangd".source = ./dotfiles/clangd;
    "eza".source = ./dotfiles/eza;
    "fastfetch".source = ./dotfiles/fastfetch;
    "foot".source = ./dotfiles/foot;
    "fuzzel".source = ./dotfiles/fuzzel;
    "gtk-3.0/settings.ini".source = ./dotfiles/gtk-3.0/settings.ini;
    "gtk-3.0/gtk.css".source = ./dotfiles/gtk-3.0/gtk.css;
    "gtk-4.0".source = ./dotfiles/gtk-4.0;
    "mpd".source = ./dotfiles/mpd;
    "mpv".source = ./dotfiles/mpv;
    "rustidle".source = ./dotfiles/rustidle;
    "udiskrs".source = ./dotfiles/udiskrs;
    "xdg-desktop-portal".source = ./dotfiles/xdg-desktop-portal;
    "btop/themes".source = ./dotfiles/btop/themes;
    "ripgrep".source = ./dotfiles/ripgrep;
    "ov".source = ./dotfiles/ov;
    "satty".source = ./dotfiles/satty;
    "swaylock".source = ./dotfiles/swaylock;
    "fnott".source = ./dotfiles/fnott;
    "yt-dlp".source = ./dotfiles/yt-dlp;

    "wgetrc".source = ./dotfiles/wgetrc;
    "user-dirs.dirs".source = ./dotfiles/user-dirs.dirs;

    "electron-flags.conf".source = ./dotfiles/electron-flags.conf;
    "signal-desktop-flags.conf".source = ./dotfiles/electron-flags.conf;
    "vesktop-flags.conf".source = ./dotfiles/electron-flags.conf;
    "obsidian/user-flags.conf".source = ./dotfiles/electron-flags.conf;
  };
}
