{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = import ./foot-data.nix;
  };

  xdg.configFile."foot/themes/catppuccin-mocha".source = formats.ini.generate "catppuccin-mocha" (
    import ./foot-theme-data.nix
  );
}
