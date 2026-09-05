{
  signal-desktop,
  electron_43,
  asar,
  makeWrapper,
  runCommandLocal,
  lib,
}:

runCommandLocal "signal-desktop-custom-${signal-desktop.version}"
  {
    nativeBuildInputs = [
      asar
      makeWrapper
    ];
    inherit (signal-desktop) meta;
    inherit (signal-desktop) passthru;
  }
  ''
    mkdir -p $out
    cp -rs --no-preserve=mode "${signal-desktop}"/. "$out"/

    resources="$out/share/signal-desktop"
    rm "$resources/app.asar"
    rm -rf "$resources/app.asar.unpacked"
    asar e "${signal-desktop}/share/signal-desktop/app.asar" "$TMPDIR/patched-asar"
    sed -E -e 's/000000|191919|1e1e1e/18000f/g' \
           -e 's/282828|373737/300028/g' \
           -e 's/22675f|323232|3b3b3b/380030/g' \
           -i "$TMPDIR/patched-asar/stylesheets/"*
    asar p "$TMPDIR/patched-asar" "$resources/app.asar" --unpack '*.node'

    rm "$out/bin/signal-desktop"
    makeWrapper "${lib.getExe electron_43}" "$out/bin/signal-desktop" \
      --set-default ELECTRON_FORCE_IS_PACKAGED 1 \
      --add-flags "$resources/app.asar" \
      --add-flags ${
        lib.escapeShellArg (
          lib.concatStringsSep " " [
            "--enable-features=UseOzonePlatform,WaylandWindowDecorations,AllowQt,VaapiVideoDecoder,VaapiIgnoreDriverChecks"
            "--ozone-platform=wayland"
            "--password-store=gnome-libsecret"
            "--gtk-version=4"
            "--enable-unsafe-webgpu"
          ]
        )
      }
  ''
