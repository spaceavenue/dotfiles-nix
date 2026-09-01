{ lib, rustPlatform, runCommand, installShellFiles }:

let
  src = builtins.fetchGit {
    url = "https://github.com/helix-editor/helix.git";
    ref = "master";
  };

  defaultRuntimeDir = runCommand "helix-custom-default-runtime" { } ''
    cp -r --no-preserve=mode ${src}/runtime $out
    rm -rf $out/grammars $out/queries
  '';
in
rustPlatform.buildRustPackage {
  pname = "helix-custom";
  version = "unstable-${src.shortRev}";

  inherit src;

  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [ installShellFiles ];

  env = {
    HELIX_DISABLE_AUTO_GRAMMAR_BUILD = "1";
    HELIX_DEFAULT_RUNTIME = defaultRuntimeDir;
    RUSTFLAGS = "-C target-cpu=native";
  };

  postInstall = ''
    installShellCompletion contrib/completion/hx.{bash,fish,zsh}
  '';

  doCheck = false;

  meta = {
    description = "Post-modern modal text editor (git version)";
    homepage = "https://helix-editor.com";
    license = lib.licenses.mpl20;
    mainProgram = "hx";
  };
}
