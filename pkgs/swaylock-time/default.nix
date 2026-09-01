{ swaylock }:

swaylock.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [ ./swaylock-clock.patch ];
  env = (old.env or { }) // { NIX_CFLAGS_COMPILE = "-march=native -O3"; };
})
