{ lib, stdenv, fetchFromSourcehut, meson, ninja, pkg-config, wayland-protocols, asciidoc, cmake
, libGLU, libheif, icu, inih, lcms2, libjpeg_turbo, libjxl, libnsgif, libnsbmp, libpng, librsvg, libtiff, libwebp
, libxkbcommon, pango, qoi, qoz, wayland, wayland-scanner }:

stdenv.mkDerivation rec {
  pname = "imv-custom";
  version = "unstable";
  src = fetchFromSourcehut {
    owner = "~exec64";
    repo = "imv";
    rev = "7dc0ddad88dcda466067028bea319216e40d4cbe";
    hash = "sha256-EXM8BLjOet+Kr73F4mAcvI9RDDUFTa8r1ZijWR8MEto=";
  };

  patches = [ ./qoz.patch ];

  postPatch = ''
    sed -i "s/unicode_lib = dependency('icu-io')/unicode_lib = dependency('icu-uc')/" meson.build
  '';

  nativeBuildInputs = 
    [ 
      meson 
      ninja 
      pkg-config 
      wayland-protocols 
      asciidoc 
      cmake 
      wayland 
      wayland-scanner 
    ];
  buildInputs = 
    [ 
      libGLU 
      libheif 
      icu 
      inih 
      lcms2 
      libjpeg_turbo 
      libjxl 
      libnsgif 
      libnsbmp 
      libpng 
      librsvg 
      libtiff 
      libwebp 
      libxkbcommon 
      pango 
      qoi 
      qoz 
      wayland 
    ];

  mesonFlags = [ "-Dtest=disabled" "-Dwindows=wayland" ];
  env.NIX_CFLAGS_COMPILE = "-march=native -O3";

  meta = {
    description = "Command line image viewer intended for use with tiling window managers, with qoz support";
    homepage = "https://git.sr.ht/~exec64/imv";
    license = lib.licenses.mit;
    mainProgram = "imv";
  };
}
