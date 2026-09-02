{
  lib,
  stdenvNoCC,
  fetchzip,
  python3Packages,
}:

stdenvNoCC.mkDerivation rec {
  pname = "ttf-ibm-plex-custom";
  version = "6.4.0";

  src = fetchzip {
    url = "https://github.com/IBM/plex/releases/download/v${version}/TrueType.zip";
    hash = "sha256-AKaGYF00ggQiC0URftZXWWtiMCLDMHQ5frZ7xhUaCco=";
    stripRoot = false;
  };

  nativeBuildInputs = [ python3Packages.fonttools ];

  buildPhase = ''
    runHook preBuild
    fonttools ttLib -o IBMPlexSans.ttc \
      $(find . -name "IBMPlexSans-Regular.ttf") \
      $(find . -name "IBMPlexSans-Bold.ttf") \
      $(find . -name "IBMPlexSans-Italic.ttf") \
      $(find . -name "IBMPlexSans-BoldItalic.ttf")
    fonttools ttLib -o IBMPlexSerif.ttc \
      $(find . -name "IBMPlexSerif-Regular.ttf") \
      $(find . -name "IBMPlexSerif-Bold.ttf") \
      $(find . -name "IBMPlexSerif-Italic.ttf") \
      $(find . -name "IBMPlexSerif-BoldItalic.ttf")
    for script in Arabic Devanagari Hebrew JP KR TC Thai ThaiLooped; do
      fonttools ttLib -o "IBMPlexSans$script.ttc" \
        $(find . -name "IBMPlexSans$script-Regular.ttf") \
        $(find . -name "IBMPlexSans$script-Bold.ttf")
    done
    runHook postBuild
  '';

  installPhase = ''
    install -Dm644 *.ttc -t $out/share/fonts/truetype
  '';

  meta = {
    description = "Custom packed TTC font collections for IBM Plex (All Languages, Regular & Bold weights only)";
    homepage = "https://github.com/IBM/plex";
    license = lib.licenses.ofl;
  };
}
