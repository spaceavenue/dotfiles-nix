{ pkgs, lib, ... }:

let
  formats = import ../../lib/formats.nix { inherit pkgs lib; };
  assets = import ./assets.nix { inherit pkgs; };
in
{
  home.packages = [ pkgs.mpv ];

  xdg.configFile = {
    "mpv/mpv.conf".text = import ./mpv-conf.nix;
    "mpv/input.conf".text = import ./input.nix;

    "mpv/scripts/modernz.lua".source = assets.scripts.modernz;
    "mpv/scripts/playlistmanager.lua".source = assets.scripts.playlistmanager;
    "mpv/scripts/autoload.lua".source = assets.scripts.autoload;
    "mpv/scripts/acompressor.lua".source = assets.scripts.acompressor;
    "mpv/scripts/seek-to.lua".source = assets.scripts.seekTo;
    "mpv/scripts/webm.lua".source = assets.scripts.webm;
    "mpv/scripts/audio-osc.lua".text = import ./audio-osc.nix;

    "mpv/shaders/ravu-zoom-ar-r3-rgb.hook".source = assets.shaders.ravuZoom;
    "mpv/shaders/CfL_Prediction.glsl".source = assets.shaders.cflPrediction;
    "mpv/shaders/JointBilateral.glsl".source = assets.shaders.jointBilateral;
    "mpv/shaders/FastBilateral.glsl".source = assets.shaders.fastBilateral;

    "mpv/fonts/modernz-icons.ttf".source = assets.fonts.modernzIcons;

    "mpv/script-opts/stats.conf".source = formats.keyValue.generate "stats.conf" (
      import ./script-opts/stats.nix
    );
    "mpv/script-opts/playlistmanager.conf".source = formats.keyValue.generate "playlistmanager.conf" (
      import ./script-opts/playlistmanager.nix
    );
    "mpv/script-opts/modernz.conf".source = formats.keyValue.generate "modernz.conf" (
      import ./script-opts/modernz.nix
    );
  };
}
