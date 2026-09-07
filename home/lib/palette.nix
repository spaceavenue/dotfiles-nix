/*
  usage:
    let palette = import ../lib/palette.nix; in { foo = palette.red; }
  or, inside a raw string:
    ''... ${palette.red} ...''
*/
{
  # catppuccin mocha
  rosewater = "#f5e0dc";
  flamingo = "#f2cdcd";
  pink = "#f5c2e7";
  mauve = "#cba6f7";
  red = "#f38ba8";
  maroon = "#eba0ac";
  peach = "#fab387";
  yellow = "#f9e2af";
  green = "#a6e3a1";
  teal = "#94e2d5";
  sky = "#89dceb";
  sapphire = "#74c7ec";
  blue = "#89b4fa";
  lavender = "#b4befe";
  mochaText = "#cdd6f4";
  mochaBase = "#1e1e2e";
  mochaCrust = "#11111b";
  subtext0 = "#a6adc8";
  subtext1 = "#bac2de";
  overlay2 = "#9399b2";

  # custom stuff replacing stock base/mantle/crust/text/subtext
  text = "#ffd1db";
  subtext = "#ac798a";
  overlay1 = "#7f849c";
  overlay0 = "#6c7086";
  surface2 = "#585b70";
  surface1 = "#45475a";
  surface0 = "#313244";
  base = "#18000f";
  crust = "#12000c";

  # darker panel/surfaces
  surfaceDark0 = "#1d0213";
  surfaceDark1 = "#240518";
  surfaceDark2 = "#2c081e";

  # muted rose/mauve accent
  muted = "#cc99aa";
  # dim/placeholder accent
  dim = "#5a4549";
  # darker accent shade
  accentDark = "#720043";
  # guide/indent-line accent
  guide = "#38122c";
  # salmon accent
  salmon = "#ffabab";
  # dark shadow tone
  shadow = "#180004";
  # muted grey-purple
  haze = "#6e6a86";
  # muted discord tag-color variants
  mutedRed = "#af667e";
  mutedPeach = "#a0745d";
  mutedYellow = "#877c66";
  mutedGreen = "#658766";
  mutedBlue = "#607daf";
  mutedMauve = "#8a72aa";
  mutedPink = "#91758d";
}
