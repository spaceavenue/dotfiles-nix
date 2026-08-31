{ lib, stdenvNoCC, buildNpmPackage, fetchFromGitHub, go-toml, ttfautohint-nox }:

buildNpmPackage rec {
  pname = "ttc-iosevka-collection";
  version = "34.8.0";

  src = fetchFromGitHub {
    owner = "be5invis";
    repo = "Iosevka";
    rev = "main";
    hash = "sha256-qlpa+Rmi/l1Gf4Hgl8O8HbYtdywpNlulFpnUvXQ2ssk=";
  };

  npmDepsHash = "sha256-0+v+bMNL1QWuMRk3rQu8PRSeNJ459JVVhvnG1qlvty4=";

  nativeBuildInputs = [ go-toml ttfautohint-nox ];

  strictDeps = true;

  postPatch = ''
    cp ${./private-build-plans.toml} private-build-plans.toml
  '';

  buildPhase = ''
    runHook preBuild
    export HOME=$TMPDIR
    for plan in IosevkaSS06 IosevkaAile IosevkaEtoile; do
      npm run build --no-update-notifier --targets ttc::"$plan" -- --jCmd=$NIX_BUILD_CORES | cat
    done
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    fontdir="$out/share/fonts/truetype"
    install -d "$fontdir"
    for plan in IosevkaSS06 IosevkaAile IosevkaEtoile; do
      install -Dm644 "dist/.ttc/$plan"/*.ttc -t "$fontdir"
    done
    runHook postInstall
  '';

  enableParallelBuilding = true;
  requiredSystemFeatures = [ "big-parallel" ];

  __structuredAttrs = true;

  meta = {
    description = "Custom Iosevka SS06/Term SS06/Aile/Etoile build";
    homepage = "https://typeof.net/Iosevka/";
    license = lib.licenses.ofl;
  };
}
