{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "dump-bgra";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "dump-bgra";
    rev = "main";
    hash = "sha256-eMQgY0Ldr2EFJX2gEtEX4uHhKlJFd2FICpGtFAPXRKE=";
  };

  # This Cargo.lock is the project's own deps plus every registry package from rust-src's
  # library/Cargo.lock merged in, purely so they're all vendored.
  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "qoz-1.0.0" = "sha256-z8cmiD+b7vqzve1JyrFbePBSFMUpedJnEZf3DujsH5E=";
    };
  };
  # `-Z build-std` also makes cargo want to record the sysroot workspace
  # members into Cargo.lock as it resolves.
  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
    chmod +w Cargo.lock
  '';

  # Broken right now.
  doCheck = false;

  meta = {
    description = "Dump pixels in bgra raw format";
    homepage = "https://github.com/spaceavenue/dump-bgra";
  };
}
