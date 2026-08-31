{ swaylock }:

swaylock.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [ ./swaylock-clock.patch ];
})
