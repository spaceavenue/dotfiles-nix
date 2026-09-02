{ config, ... }:

{
  services.mpd = {
    enable = true;
    enableSessionVariables = false;

    musicDirectory = "${config.home.homeDirectory}/msc";
    playlistDirectory = "${config.home.homeDirectory}/msc/mpd_playlists";
    dataDir = "${config.home.homeDirectory}/.local/share/mpd";
    dbFile = "${config.home.homeDirectory}/.local/share/mpd/mpd.db";

    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
      startWhenNeeded = true;
    };

    extraConfig = ''
      log_file "syslog"
      auto_update "yes"
      restore_paused "yes"
      max_output_buffer_size "16384"

      audio_output {
      	type "pipewire"
      	name "pipewire"
      }

      audio_output {
             type	"fifo"
             name	"Visualizer feed"
             path	"/tmp/mpd.fifo"
             format	"44100:16:2"
      }
    '';
  };
}
