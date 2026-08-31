{ wtype }:

wtype.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [ ./wtype-chromium-keycode.patch ];
})
