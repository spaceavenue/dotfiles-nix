{ wtype }:

wtype.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [ ./wtype-chromium-keycode.patch ];
  env = (old.env or { }) // {
    NIX_CFLAGS_COMPILE = "-march=native -O3";
  };
})
