{
  lib,
  fetchurl,
  stdenvNoCC,
  python3Packages,
}:

let
  # each script is pinned to its own latest release tag instead of
  # nixpkgs' shared, older ttf-ibm-plex-* pin.
  # also only the CJK families ship a hinted variant.
  scripts = {
    Arabic = {
      version = "1.1.0";
      hinted = false;
    };
    Devanagari = {
      version = "1.1.0";
      hinted = false;
    };
    Hebrew = {
      version = "1.1.0";
      hinted = false;
    };
    JP = {
      version = "3.0.0";
      hinted = true;
    };
    KR = {
      version = "1.1.0";
      hinted = true;
    };
    TC = {
      version = "1.1.1";
      hinted = true;
    };
    Thai = {
      version = "1.1.0";
      hinted = false;
    };
    ThaiLooped = {
      version = "1.1.0";
      hinted = false;
    };
  };

  hashes = {
    "Arabic-Regular" = "sha256-jg8QRsc2v5OdSTnuOuARas9hy81lkt6udlZ2FicICYE=";
    "Arabic-Bold" = "sha256-t0+AnerRJELtVuAqEsO8wCB2ya1OMvF9Cpym/BqvyJ4=";
    "Devanagari-Regular" = "sha256-89gugnl8jNKekXHzIXTtXuGojhMtG6r74hI3xCMgMEs=";
    "Devanagari-Bold" = "sha256-XuFImPO/VxnsDd3HTV8JhNHlxSAdvjCIkyamIBR7wlE=";
    "Hebrew-Regular" = "sha256-mM2MoT/vR/tXwg+u0Xo0Zjm7QYt6vrCW/ZaT6j7sxEU=";
    "Hebrew-Bold" = "sha256-YoxdrBX2G4yYFilCbMddISPPJVIJJr8o+hoGDCzQlvs=";
    "JP-Regular" = "sha256-5enulJ4FyiW/db5E1kEscHH83rjKbENhqNauuB+WKJo=";
    "JP-Bold" = "sha256-G8n6u2lpFd9m9Z+Z/kULIfodbkh0khPRgrFzNngyoRg=";
    "KR-Regular" = "sha256-GTr0wMT5eSUe3RNwjqTD600NB/k1Kz0qWLQ7BCdnGDs=";
    "KR-Bold" = "sha256-KqSZCaba4Fke+hzIkr+ZolVrO1b7y2OUOSQAEFGFSK4=";
    "TC-Regular" = "sha256-ZUZ3FW/8m6NVA/9Wmk1VvHBEUB8FW9d1KkBERe0xzuc=";
    "TC-Bold" = "sha256-NGKma4vh9SoECOvBbAmeC5yq4L+oFy7Lnn80Jnw1+Y4=";
    "Thai-Regular" = "sha256-g+HbjoutBrt2CYHx3VKPXyCdIN+t66wSshvy8SRTyMY=";
    "Thai-Bold" = "sha256-ZEUSKZFs+/qLsbvfNnS4upbADgTTvIHRSLe/uDMNj9g=";
    "ThaiLooped-Regular" = "sha256-M4eHh0VfZUGO/vHHZt87O03bhfksM1dXtlVwzIG+FTQ=";
    "ThaiLooped-Bold" = "sha256-p3neEVFiv5iwcoCMG+eube9n3M0FbsIraMnviinMOhw=";
  };

  # npm-style tags contain characters ('/', '@') that need percent-encoding
  # to be in a URL (grr i hate this version scheme).
  # ThaiLooped is the one script whose lowercased name doesn't match its
  # package/tag "plex-sans-thai-looped".
  pkgOf = script: if script == "ThaiLooped" then "thai-looped" else lib.toLower script;
  pkgDirOf = script: "plex-sans-${pkgOf script}";
  tagOf = script: version: "%40ibm%2Fplex-sans-${pkgOf script}%40${version}";

  fetchWeight =
    script: weight:
    let
      inherit (scripts.${script}) version hinted;
      pkgDir = pkgDirOf script;
      hintedDir = if hinted then "hinted/" else "";
    in
    fetchurl {
      name = "IBMPlexSans${script}-${weight}.ttf";
      url = "https://raw.githubusercontent.com/IBM/plex/${tagOf script version}/packages/${pkgDir}/fonts/complete/ttf/${hintedDir}IBMPlexSans${script}-${weight}.ttf";
      sha256 = hashes."${script}-${weight}";
    };

in
stdenvNoCC.mkDerivation {
  pname = "ttf-ibm-plex-custom";
  version = lib.concatStringsSep "_" (
    lib.mapAttrsToList (script: v: "${script}-${v.version}") scripts
  );

  dontUnpack = true;
  nativeBuildInputs = [ python3Packages.fonttools ];

  buildPhase = ''
    runHook preBuild
    ${lib.concatMapStringsSep "\n" (script: ''
      fonttools ttLib -o "IBMPlexSans${script}.ttc" \
        ${fetchWeight script "Regular"} ${fetchWeight script "Bold"}
    '') (lib.attrNames scripts)}
    runHook postBuild
  '';

  installPhase = ''
    install -Dm644 *.ttc -t $out/share/fonts/truetype
  '';

  meta = {
    description = "Custom TTC collections for IBM Plex (Non-English languages, Regular & Bold weights only)";
    homepage = "https://github.com/IBM/plex";
    license = lib.licenses.ofl;
  };
}
