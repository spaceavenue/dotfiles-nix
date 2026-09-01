let
  esc = builtins.fromJSON (''"\'' + ''u001b"'');
in
{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
  logo.color = {
    "1" = "#ffd1db";
    "2" = "#f38ba8";
    "3" = "#ffd1db";
    "4" = "#f38ba8";
    "5" = "#ffd1db";
    "6" = "#f38ba8";
  };
  display = {
    separator = " │ ";
    color = {
      keys = "#ffd1db";
      output = "#f38ba8";
      separator = "#cba6f7";
    };
    temp = {
      green = "#cba6f7";
      yellow = "#cba6f7";
      red = "#cba6f7";
    };
    percent = {
      type = [ "num" "num-color" ];
      color = {
        green = "#cba6f7";
        yellow = "#cba6f7";
        red = "#cba6f7";
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
    { key = "{$2}host     "; type = "host"; }
    { key = "{$2}distro   "; type = "os"; }
    { key = "{$2}kernel   "; type = "kernel"; }
    { key = "{$2}uptime   "; type = "uptime"; }
    { key = "{$2}packages "; type = "packages"; }
    { key = "{$2}wm       "; type = "wm"; }
    { key = "{$2}term     "; type = "terminal"; }
    { key = "{$2}shell    "; type = "shell"; }
    { key = "{$2}cpu      "; type = "cpu"; showPeCoreCount = true; }
    { key = "{$2}gpu      "; type = "gpu"; }
    { key = "{$2}memory   "; type = "memory"; }
    {
      key = "{$2}disk     ";
      type = "disk";
      format = "{size-used} / {size-total} ({size-percentage})";
    }
    { format = "{#separator}╰{$1}╯"; type = "custom"; }
  ];
}
