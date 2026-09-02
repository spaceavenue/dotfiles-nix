{
  lib,
  rustPlatform,
  fetchFromGitHub,
  file,
  makeWrapper,
}:

rustPlatform.buildRustPackage rec {
  pname = "rustclip";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "rustclip";
    rev = "main";
    hash = "sha256-oUJMiDIjzSiYbq/x5Wpk3EprvMUuHc4tmyRhqjqeU6g=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "wllib-0.1.0" = "sha256-6QJv0BSqerYWCdEIp7ldwYRvq73sONEwRClwa2eAj7Q=";
    };
  };
  # --offline requires the *entire* sysroot workspace lockfile to resolve, including members we
  # don't actually build (e.g. proc_macro's rustc-literal-escaper). This Cargo.lock is the
  # project's own deps plus every registry package from rust-src's library/Cargo.lock merged in,
  # purely so they're all vendored. `-Z build-std` also makes cargo want to record the sysroot
  # workspace members into Cargo.lock as it resolves.
  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
    chmod +w Cargo.lock
  '';

  doCheck = false;

  nativeBuildInputs = [ makeWrapper ];
  postFixup = ''
    for bin in wl-copy wl-paste wl-watch; do
      wrapProgram "$out/bin/$bin" --prefix PATH : "${lib.makeBinPath [ file ]}"
    done
  '';

  meta = {
    description = "Tiny, minimal utility for interacting with the Wayland clipboard";
    homepage = "https://github.com/spaceavenue/rustclip";
  };
}
