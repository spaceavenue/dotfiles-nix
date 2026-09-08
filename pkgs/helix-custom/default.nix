{
  lib,
  rustPlatform,
  fetchFromGitHub,
  runCommand,
  installShellFiles,
  makeBinaryWrapper,
  tree-sitter-grammars,
  removeReferencesTo,
}:

let
  src = fetchFromGitHub {
    owner = "helix-editor";
    repo = "helix";
    rev = "master";
    hash = "sha256-IYDL6Vnf13Sa+wbeXZTAxvdLA4h8Ew5ha0spcJy/Yk0=";
  };

  languages = builtins.fromTOML (builtins.readFile "${src}/languages.toml");
  grammarNames = map (g: g.name) languages.grammar;

  # Intersection of the grammars helix declares in its languages.toml and the ones nixpkgs happens
  # to package under the matching tree-sitter-<name> name. A handful newer/renamed grammars that
  # aren't in nixpkgs yet are skipped.
  availableGrammars = lib.filterAttrs (
    drvName: _: builtins.elem (lib.removePrefix "tree-sitter-" drvName) grammarNames
  ) tree-sitter-grammars;

  grammarsFarm = runCommand "helix-custom-grammars" { } (
    lib.concatMapAttrsStringSep "\n" (_: grammar: ''
      install -D ${grammar}/parser $out/${grammar.language}.so
      ${lib.getExe removeReferencesTo} -t ${grammar} $out/${grammar.language}.so
    '') availableGrammars
  );

  runtimeDir = runCommand "helix-custom-runtime" { } ''
    mkdir -p $out
    ln -s ${grammarsFarm} $out/grammars
    cp -r --no-preserve=mode ${src}/runtime/queries $out
  '';
in
rustPlatform.buildRustPackage {
  pname = "helix-custom";
  version = "unstable";

  inherit src;

  cargoLock.lockFile = ./Cargo.lock;

  postPatch = "cp ${./Cargo.lock} Cargo.lock";

  nativeBuildInputs = [
    installShellFiles
    makeBinaryWrapper
  ];

  env = {
    HELIX_DISABLE_AUTO_GRAMMAR_BUILD = "1";
    RUSTFLAGS = "-C target-cpu=native";
  };

  postInstall = ''
    installShellCompletion contrib/completion/hx.{bash,fish,zsh}
    wrapProgram $out/bin/hx --set HELIX_RUNTIME "${runtimeDir}"
  '';

  doCheck = false;

  passthru.runtime = runtimeDir;

  meta = {
    description = "Post-modern modal text editor (built from master branch)";
    homepage = "https://helix-editor.com";
    license = lib.licenses.mpl20;
    mainProgram = "hx";
  };
}
