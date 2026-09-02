{
  home.stateVersion = "26.05";

  imports = [
    ./core/packages.nix
    ./core/services.nix
    ./core/auto-update.nix

    ./apps/niri.nix
    ./apps/fish.nix
    ./apps/helix.nix
    ./apps/mpv
    ./apps/yazi
    ./apps/waybar
    ./apps/gtk.nix
    ./apps/fuzzel.nix
    ./apps/foot.nix
    ./apps/fnott.nix
    ./apps/satty.nix
    ./apps/portals.nix
    ./apps/eza.nix
    ./apps/ov.nix
    ./apps/fastfetch.nix
    ./apps/npm.nix
    ./apps/cava.nix
    ./apps/btop.nix
    ./apps/bat.nix
    ./apps/zed.nix
    ./apps/mpd.nix
    ./apps/rmpc.nix
    ./apps/user-dirs.nix
    ./apps/udiskrs.nix
    ./apps/rustidle.nix
    ./apps/swaylock.nix
    ./apps/ripgrep.nix
    ./apps/wgetrc.nix
    ./apps/yt-dlp.nix
    ./apps/electron-flags.nix
    ./apps/rust.nix
    ./apps/git.nix
    ./apps/beets.nix
  ];
}
