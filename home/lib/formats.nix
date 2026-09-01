# pkgs.formats.* generators, used by app modules to turn Nix data into config files at build time.
{ pkgs, lib }:

{
  toml = pkgs.formats.toml { };
  ini = pkgs.formats.ini { };
  iniGlobal = pkgs.formats.iniWithGlobalSection { };
  yaml = pkgs.formats.yaml { };
  json = pkgs.formats.json { };
  keyValue = pkgs.formats.keyValue {
    mkKeyValue = lib.generators.mkKeyValueDefault { } "=";
  };
}
