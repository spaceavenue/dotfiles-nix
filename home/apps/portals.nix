{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  xdg.configFile."xdg-desktop-portal/portals.conf".source = formats.ini.generate "portals.conf" (
    import ./portals-data.nix
  );
}
