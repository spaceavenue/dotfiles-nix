{ nightlyMuslToolchain }:

[
  (
    final: prev:
    let
      rustPackage =
        path: extraArgs:
        final.callPackage path ({ rustPlatform = final.rustNightlyPlatform; } // extraArgs);
    in
    {
      rustNightlyMuslPlatform = final.pkgsCross.musl64.makeRustPlatform {
        cargo = nightlyMuslToolchain;
        rustc = nightlyMuslToolchain;
      };

      rustNightlyPlatform = final.makeRustPlatform {
        cargo = nightlyMuslToolchain;
        rustc = nightlyMuslToolchain;
      };

      yt-dlp = prev.yt-dlp.override { jsRuntime = final.quickjs; };
      obsidian = prev.obsidian.override { inherit (final) electron; };
      vesktop = prev.vesktop.override { electron_43 = final.electron; };
      signal-desktop-custom = final.callPackage ../pkgs/signal-desktop-custom { };

      clang-mold = final.callPackage ../pkgs/clang-mold { };
      wtype-custom = final.callPackage ../pkgs/wtype-custom { };
      swaylock-time = final.callPackage ../pkgs/swaylock-time { };
      imv-custom = final.callPackage ../pkgs/imv-custom { };

      niri-custom = final.callPackage ../pkgs/niri-custom { };
      helix-custom = rustPackage ../pkgs/helix-custom { };

      dump-bgra = rustPackage ../pkgs/dump-bgra { };
      rusty-wl-utils = final.pkgsCross.musl64.callPackage ../pkgs/rusty-wl-utils {
        rustPlatform = final.rustNightlyMuslPlatform;
      };
      rustclip = final.pkgsCross.musl64.callPackage ../pkgs/rustclip {
        rustPlatform = final.rustNightlyMuslPlatform;
      };
      udiskrs = rustPackage ../pkgs/udiskrs { };
      qoz = rustPackage ../pkgs/qoz { };

      ttf-ibm-plex-custom = final.callPackage ../pkgs/ttf-ibm-plex-custom { };
      ttc-iosevka-collection = final.callPackage ../pkgs/ttc-iosevka-collection { };
    }
  )
]
