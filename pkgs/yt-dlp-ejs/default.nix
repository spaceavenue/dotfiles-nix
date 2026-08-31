{ lib, python3Packages, fetchurl }:

python3Packages.buildPythonPackage rec {
  pname = "yt-dlp-ejs";
  version = "0.8.0";
  format = "wheel";

  src = fetchurl {
    url = "https://github.com/yt-dlp/ejs/releases/download/${version}/yt_dlp_ejs-${version}-py3-none-any.whl";
    hash = "sha256-eTAOX8p/k3oe7t4R8EVoYsG0EQfOHXJoceAgdCT0vbQ=";
  };

  meta = {
    description = "Pre-built yt-dlp EJS plugins utilizing Node.js instead of Deno";
    homepage = "https://github.com/yt-dlp/ejs";
    license = lib.licenses.unlicense;
  };
}
