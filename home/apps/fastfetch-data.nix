let
  palette = import ../lib/palette.nix;
  esc = builtins.fromJSON (''"\'' + ''u001b"'');
in
{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
  logo.color = {
    "1" = palette.text;
    "2" = palette.red;
    "3" = palette.text;
    "4" = palette.red;
    "5" = palette.text;
    "6" = palette.red;
  };
  display = {
    separator = " │ ";
    color = {
      keys = palette.text;
      output = palette.red;
      separator = palette.mauve;
    };
    temp = {
      green = palette.mauve;
      yellow = palette.mauve;
      red = palette.mauve;
    };
    percent = {
      type = [
        "num"
        "num-color"
      ];
      color = {
        green = palette.mauve;
        yellow = palette.mauve;
        red = palette.mauve;
      };
    };
    constants = [
      "──────────────────────────────────────────────────"
      "${esc}[38;2;203;166;247m│${esc}[50C│${esc}[50D${esc}[38;2;255;209;219m"
    ];
  };
  modules = [
    {
      format = "{#separator}╭{$1}╮${esc}[51D {#keys}{user-name}{#separator}@{#keys}{host-name} ";
      type = "title";
    }
    {
      key = "{$2}host     ";
      type = "host";
    }
    {
      key = "{$2}distro   ";
      type = "os";
    }
    {
      key = "{$2}kernel   ";
      type = "kernel";
    }
    {
      key = "{$2}uptime   ";
      type = "uptime";
    }
    {
      key = "{$2}packages ";
      type = "packages";
    }
    {
      key = "{$2}wm       ";
      type = "wm";
    }
    {
      key = "{$2}term     ";
      type = "terminal";
    }
    {
      key = "{$2}shell    ";
      type = "shell";
    }
    {
      key = "{$2}cpu      ";
      type = "cpu";
      showPeCoreCount = true;
    }
    {
      key = "{$2}gpu      ";
      type = "gpu";
    }
    {
      key = "{$2}memory   ";
      type = "memory";
    }
    {
      key = "{$2}disk     ";
      type = "disk";
      format = "{size-used} / {size-total} ({size-percentage})";
    }
    {
      format = "{#separator}╰{$1}╯";
      type = "custom";
    }
  ];
}
