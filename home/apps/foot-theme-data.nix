let
  palette = import ../lib/palette.nix;
  # foot wants bare hex (no leading '#').
  hex = c: builtins.substring 1 6 c;
in
{
  colors-dark = {
    alpha = "0.50";
    foreground = hex palette.muted;
    background = "000000";

    regular0 = hex palette.surface1;
    regular1 = hex palette.red;
    regular2 = hex palette.green;
    regular3 = hex palette.yellow;
    regular4 = hex palette.blue;
    regular5 = hex palette.pink;
    regular6 = hex palette.teal;
    regular7 = hex palette.subtext1;

    bright0 = hex palette.surface2;
    bright1 = hex palette.red;
    bright2 = hex palette.green;
    bright3 = hex palette.yellow;
    bright4 = hex palette.blue;
    bright5 = hex palette.pink;
    bright6 = hex palette.teal;
    bright7 = hex palette.subtext0;

    "16" = hex palette.peach;
    "17" = hex palette.mauve;
    "18" = hex palette.text;

    selection-foreground = hex palette.mochaBase;
    selection-background = hex palette.text;

    search-box-no-match = "${hex palette.mochaCrust} ${hex palette.red}";
    search-box-match = "${hex palette.mochaText} ${hex palette.surface0}";

    jump-labels = "${hex palette.mochaCrust} ${hex palette.peach}";
    urls = hex palette.blue;
  };
}
