{
  projectRootFile = "flake.nix";

  programs.nixfmt.enable = true; # nixfmt-rfc-style
  programs.deadnix.enable = true; # unused let-bindings/args
  programs.statix.enable = true; # common Nix anti-patterns
}
