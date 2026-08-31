{ lib, rustPlatform, fetchFromGitHub, dav1d }:

rustPlatform.buildRustPackage rec {
  pname = "qoz";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "qoz";
    rev = "main";
    hash = "sha256-z8cmiD+b7vqzve1JyrFbePBSFMUpedJnEZf3DujsH5E=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };
  postPatch = "cp ${./Cargo.lock} Cargo.lock";
  buildInputs = [ dav1d ];

  postInstall = ''
    install -Dm644 qoz-c/qoz.h "$out/include/qoz.h"
    install -Dm644 qoz-c/qoz.pc "$out/lib/pkgconfig/qoz.pc"
    substituteInPlace "$out/lib/pkgconfig/qoz.pc" \
      --replace-fail "prefix=/usr" "prefix=$out"
  '';

  meta = {
    description = "Minimal image format storing zstd-compressed raw images, optimized for decode speed";
    homepage = "https://github.com/spaceavenue/qoz";
    license = lib.licenses.mit;
  };
}
