{ signal-desktop, asar }:

signal-desktop.overrideAttrs (old: {
  nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ asar ];
  postFixup = (old.postFixup or "") + ''
    resources="$out/share/signal-desktop"
    ${asar}/bin/asar e "$resources/app.asar" "$TMPDIR/patched-asar"
    sed -E -e 's/000000|191919|1e1e1e/18000f/g' \
           -e 's/282828|373737/300028/g' \
           -e 's/22675f|323232|3b3b3b/380030/g' \
           -i "$TMPDIR/patched-asar/stylesheets/"*
    ${asar}/bin/asar p "$TMPDIR/patched-asar" "$resources/app.asar" --unpack '*.node'
  '';
})
