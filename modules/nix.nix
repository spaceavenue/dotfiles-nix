{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.max-jobs = 3;

  nixpkgs.config.allowUnfree = true;
}
