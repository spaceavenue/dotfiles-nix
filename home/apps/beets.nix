{ pkgs, lib, ... }:

let
  formats = import ../lib/formats.nix { inherit pkgs lib; };
in
{
  home.packages = [ pkgs.beets ];

  xdg.configFile."beets/config.yaml".source = formats.yaml.generate "beets-config.yaml" {
    directory = "~/msc";
    library = "~/.local/share/beets/library.db";

    import = {
      move = false;
      copy = false;
      write = true;
    };

    id3v23 = true;
  };
}
