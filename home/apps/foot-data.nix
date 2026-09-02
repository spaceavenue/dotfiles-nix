{
  main = {
    app-id = "foot";
    font = "Iosevka Term SS06:style=Extended:size=12, Symbols Nerd Font Mono:size=12";
    font-bold = "Iosevka Term SS06:style=Bold Extended:size=12";
    font-italic = "Iosevka Term SS06:style=Extended Italic:size=12";
    font-bold-italic = "Iosevka Term SS06:style=Extended Italic:size=12";
    box-drawings-uses-font-glyphs = "yes";
    pad = "10x10 center-when-maximized-and-fullscreen";
    bold-text-in-bright = "palette-based";
    include = "~/.config/foot/themes/catppuccin-mocha";
  };

  bell.system = "no";

  scrollback.lines = "10000";

  url = {
    launch = "xdg-open \${url}";
    osc8-underline = "always";
  };

  cursor = {
    style = "underline";
    blink = "yes";
    blink-rate = "250";
    underline-thickness = "2.0";
  };
}
