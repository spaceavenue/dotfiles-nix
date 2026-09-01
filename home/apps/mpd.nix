{ pkgs, ... }:

{
  systemd.user.services.mpd = {
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

  systemd.user.sockets.mpd = {
    Unit.Description = "Music Player Daemon Socket";
    Socket.ListenStream = "127.0.0.1:6600";
    Install.WantedBy = [ "sockets.target" ];
  };

  xdg.configFile."mpd/mpd.conf".text = import ./mpd-data.nix;
}
