# Per-user toolchain manager (state in ~/.rustup, ~/.cargo). No config file
# of its own to inline.
{ pkgs, ... }:

{
  home.packages = [ pkgs.rustup ];
}
