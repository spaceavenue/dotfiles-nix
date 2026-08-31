{ nightlyMuslToolchain }:

[
  (final: prev: {
    # nightly + musl rustPlatform
    # A real musl *target* requires building against pkgsCross.musl64's stdenv. 
    # plain makeRustPlatform on the normal glibc stdenv just produces a glibc-linked binary regardless
    # of which rustc/cargo you hand it, since buildRustPackage derives its --target from
    # stdenv.hostPlatform, not from the toolchain.
    rustNightlyMuslPlatform = final.pkgsCross.musl64.makeRustPlatform {
      cargo = nightlyMuslToolchain;
      rustc = nightlyMuslToolchain;
    };

    rustNightlyPlatform = final.makeRustPlatform {
      cargo = nightlyMuslToolchain;
      rustc = nightlyMuslToolchain;
    };

    obsidian = prev.obsidian.override { electron = final.electron; };
    vesktop  = prev.vesktop.override  { electron_43 = final.electron; };
    signal-desktop-custom = final.callPackage ../pkgs/signal-desktop-custom { };
    wtype-custom          = final.callPackage ../pkgs/wtype-custom { };
    swaylock-time         = final.callPackage ../pkgs/swaylock-time { };
    niri-custom    = final.callPackage ../pkgs/niri-custom { };
    dump-bgra = final.callPackage ../pkgs/dump-bgra {
      rustPlatform = final.rustNightlyPlatform;
    };
    rusty-wl-utils = final.pkgsCross.musl64.callPackage ../pkgs/rusty-wl-utils {
      rustPlatform = final.rustNightlyMuslPlatform;
    };
    rustclip = final.pkgsCross.musl64.callPackage ../pkgs/rustclip {
      rustPlatform = final.rustNightlyMuslPlatform;
    };
    udiskrs    = final.callPackage ../pkgs/udiskrs { };
    qoz        = final.callPackage ../pkgs/qoz { };
    imv-custom = final.callPackage ../pkgs/imv-custom { };
    ttf-ibm-plex-custom  = final.callPackage ../pkgs/ttf-ibm-plex-custom { };
    yt-dlp-ejs           = final.callPackage ../pkgs/yt-dlp-ejs { };
    ttc-iosevka-collection = final.callPackage ../pkgs/ttc-iosevka-collection { };
    clang-mold = final.callPackage ../pkgs/clang-mold { };
  })
]
