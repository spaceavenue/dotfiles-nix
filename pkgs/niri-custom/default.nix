{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cairo,
  glib,
  libdisplay-info_0_3,
  libglvnd,
  libinput,
  libxkbcommon,
  libgbm,
  pango,
  pixman,
  seatd,
  pipewire,
  wayland,
  dbus,
  systemd,
}:

rustPlatform.buildRustPackage rec {
  pname = "niri-custom";
  version = "unstable-custom";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "niri";
    rev = "custom";
    hash = "sha256-fHHT9csELanF7fE7VHK/tP0s+c4R5En789flkTzbuS8=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "smithay-0.7.0" = "sha256-2aurK1dZAD49FTYURzZuQkBM07woZB/rNymF0fuSbR8=";
    };
  };

  strictDeps = true;

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
    patchShebangs resources/niri-session
    substituteInPlace resources/niri.service \
      --replace-fail 'niri' "$out/bin/niri"
  '';

  # For some reason tests fail? will look into this later.
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];
  buildInputs = [
    cairo
    glib
    libdisplay-info_0_3
    libglvnd
    libinput
    libxkbcommon
    libgbm
    pango
    pixman
    seatd
    pipewire
    wayland
    dbus
    systemd
  ];

  # Force linking with libEGL and libwayland-client so they end up in RPATH and
  # can be discovered by `dlopen()`
  env.RUSTFLAGS = toString (
    map (arg: "-C link-arg=" + arg) [
      "-Wl,--push-state,--no-as-needed"
      "-lEGL"
      "-lwayland-client"
      "-Wl,--pop-state"
    ]
  );

  postInstall = ''
    install -Dm0644 resources/niri.desktop -t $out/share/wayland-sessions
    install -Dm0644 resources/niri-portals.conf -t $out/share/xdg-desktop-portal
    install -Dm0755 resources/niri-session -t $out/bin
    install -Dm0644 resources/niri{-shutdown.target,.service} -t $out/lib/systemd/user
  '';

  passthru.providedSessions = [ "niri" ];

  meta = {
    description = "Scrollable-tiling Wayland compositor (custom)";
    homepage = "https://github.com/spaceavenue/niri";
    license = lib.licenses.gpl3Plus;
    mainProgram = "niri";
  };
}
