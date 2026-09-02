_:

{
  services.fnott = {
    enable = true;
    settings = import ./fnott-data.nix;
  };
}
