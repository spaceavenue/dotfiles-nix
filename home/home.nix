{ config, pkgs, lib, ... }:

let
  formats = {
    toml = pkgs.formats.toml { };
    ini = pkgs.formats.ini { };
    iniGlobal = pkgs.formats.iniWithGlobalSection { };
    yaml = pkgs.formats.yaml { };
    json = pkgs.formats.json { };
    keyValue = pkgs.formats.keyValue {
      mkKeyValue = lib.generators.mkKeyValueDefault { } "=";
    };
  };

  electronFlags = ''
    --enable-features=UseOzonePlatform,WaylandWindowDecorations,AllowQt,VaapiVideoDecoder,VaapiIgnoreDriverChecks
    --ozone-platform=wayland
    --password-store=gnome-libsecret
    --gtk-version=4
    --enable-unsafe-webgpu
  '';
in
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

    "mpv/scripts".source = ./dotfiles/mpv/scripts;
    "mpv/shaders".source = ./dotfiles/mpv/shaders;
    "mpv/fonts".source = ./dotfiles/mpv/fonts;

    "satty/config.toml".source = formats.toml.generate "satty-config.toml" (import ./inline/satty.nix);
    "fuzzel/theme.ini".source = formats.ini.generate "fuzzel-theme.ini" (import ./inline/fuzzel-theme.nix);
    "gtk-3.0/settings.ini".source = formats.ini.generate "gtk3-settings.ini" (import ./inline/gtk3-settings.nix);
    "gtk-4.0/settings.ini".source = formats.ini.generate "gtk4-settings.ini" (import ./inline/gtk3-settings.nix);
    "xdg-desktop-portal/portals.conf".source = formats.ini.generate "portals.conf" (import ./inline/portals.nix);
    "fnott/fnott.ini".source = formats.ini.generate "fnott.ini" (import ./inline/fnott.nix);
    "foot/foot.ini".source = formats.iniGlobal.generate "foot.ini" (import ./inline/foot.nix);
    "foot/themes/catppuccin-mocha".source = formats.ini.generate "catppuccin-mocha" (import ./inline/foot-theme.nix);
    "eza/theme.yml".source = formats.yaml.generate "eza-theme.yml" (import ./inline/eza-theme.nix);
    "ov/config.yaml".source = formats.yaml.generate "ov-config.yaml" (import ./inline/ov.nix);
    "fastfetch/config.jsonc".source = formats.json.generate "config.jsonc" (import ./inline/fastfetch.nix);
    "npm/npmrc".source = formats.keyValue.generate "npmrc" (import ./inline/npmrc.nix);
    "cava/config".source = formats.ini.generate "cava-config" (import ./inline/cava.nix);
    "fuzzel/fuzzel.ini".source = formats.iniGlobal.generate "fuzzel.ini" (import ./inline/fuzzel.nix);
    "btop/themes/main.theme".source = formats.keyValue.generate "main.theme" (import ./inline/btop-theme.nix);
    "bat/themes/Theme.tmTheme".text = import ./inline/bat-theme.nix;
    "gtk-3.0/gtk.css".text = import ./inline/gtk3-css.nix;
    "gtk-4.0/gtk.css".text = import ./inline/gtk4-css.nix;
    "zed/themes/theme.json".source = formats.json.generate "theme.json" (import ./inline/zed-theme.nix);
    "mpd/mpd.conf".text = import ./inline/mpd.nix;
    "mpv/mpv.conf".text = import ./inline/mpv.nix;
    "mpv/input.conf".text = import ./inline/mpv-input.nix;
    "mpv/script-opts/stats.conf".source = formats.keyValue.generate "stats.conf" (import ./inline/mpv-stats.nix);
    "mpv/script-opts/playlistmanager.conf".source = formats.keyValue.generate "playlistmanager.conf" (import ./inline/mpv-playlistmanager.nix);
    "mpv/script-opts/modernz.conf".source = formats.keyValue.generate "modernz.conf" (import ./inline/mpv-modernz.nix);

    "rmpc/config.ron".text = import ./inline/rmpc.nix;
    "rmpc/themes/main.ron".text = import ./inline/rmpc-theme.nix;

    "user-dirs.dirs".source = formats.keyValue.generate "user-dirs.dirs" (import ./inline/user-dirs.nix);

    "udiskrs/mounts.conf".text = ''
      61d36ac1-d443-472b-8f5c-e90a6dc312ae rw,noatime,compress=zstd:3,ssd,discard=async,space_cache=v2,subvol=/@backup
    '';

    "rustidle/config".text = ''
      timeout 170 notify-send -a "Rustidle" "Idle Imminent" "System will lock in 10s"
      timeout 180 swaylock
      timeout 180 niri msg action power-off-monitors
    '';

    "swaylock/config".text = ''
      ignore-empty-password
      daemonize

      image="/home/sanya/.config/current_wallpaper_blurred"

      clock
      timestr=%T
      datestr=%a, %d %b %Y

      font=Iosevka Etoile
      indicator-idle-visible
      indicator-radius=300
      indicator-thickness=15

      inside-color=00000000
      inside-clear-color=00000000
      inside-ver-color=00000000
      inside-wrong-color=00000000

      key-hl-color=ffd1dbff
      bs-hl-color=ffd1dbff

      line-color=00000000
      line-clear-color=00000000
      line-ver-color=00000000
      line-wrong-color=00000000

      ring-color=00000000
      ring-clear-color=720043ff
      ring-ver-color=720043ff
      ring-wrong-color=ff4444ff

      separator-color=00000000

      text-color=ffd1dbff
      text-clear-color=f38ba8ff
      text-ver-color=f38ba8ff
      text-wrong-color=f38ba8ff
    '';

    "ripgrep/config".text = ''
      --smart-case
      --colors=path:fg:243,139,168
      --colors=line:fg:203,166,247
      --colors=match:fg:255,209,219
      --colors=match:style:bold
    '';

    "bat/config".text = ''
      --theme="Theme"
      --italic-text=always
      --paging=never
    '';

    "wgetrc".text = ''
      hsts-file = /home/sanya/.local/state/wget-hsts
    '';

    "yt-dlp/config".text = ''
      --js-runtimes quickjs
    '';

    "electron-flags.conf".text = electronFlags;
    "signal-desktop-flags.conf".text = electronFlags;
    "vesktop-flags.conf".text = electronFlags;
    "obsidian/user-flags.conf".text = electronFlags;
  };
}
