{ pkgs, ... }:

{
  home.packages = [ pkgs.ripgrep ];

  xdg.configFile."ripgrep/config".text = ''
    --smart-case
    --colors=path:fg:243,139,168
    --colors=line:fg:203,166,247
    --colors=match:fg:255,209,219
    --colors=match:style:bold
  '';
}
