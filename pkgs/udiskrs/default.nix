{ lib, rustPlatform, fetchFromGitHub, udisks2 }:

rustPlatform.buildRustPackage rec {
  pname = "udiskrs";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "udiskrs";
    rev = "main";
    hash = "sha256-iE8n2NrITdAcA57VgMDPMII1+shYY93TjDf+FNw3W8U=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };
  postPatch = "cp ${./Cargo.lock} Cargo.lock";
  buildInputs = [ udisks2 ];

  meta = {
    description = "UDisks2 mount manager";
    homepage = "https://github.com/spaceavenue/udiskrs";
  };
}
