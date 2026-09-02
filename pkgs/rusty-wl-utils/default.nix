{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "rusty-wl-utils";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "spaceavenue";
    repo = "rusty-wl-utils";
    rev = "main";
    hash = "sha256-l/KIGMm1G9h4A5+xmBnq+lfgQG0n5c/76FmHpDRl7dI=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "wllib-0.1.0" = "sha256-6QJv0BSqerYWCdEIp7ldwYRvq73sONEwRClwa2eAj7Q=";
    };
  };
  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
    chmod +w Cargo.lock
  '';

  doCheck = false;

  meta = {
    description = "Minimal Wayland utilities";
    homepage = "https://github.com/spaceavenue/rusty-wl-utils";
  };
}
