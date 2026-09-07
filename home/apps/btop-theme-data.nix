let
  palette = import ../lib/palette.nix;
in
{
  "theme[main_bg]" = "\"\"";
  "theme[main_fg]" = "\"${palette.red}\"";
  "theme[title]" = "\"${palette.text}\"";
  "theme[hi_fg]" = "\"${palette.mauve}\"";
  "theme[selected_bg]" = "\"${palette.text}\"";
  "theme[selected_fg]" = "\"${palette.accentDark}\"";
  "theme[inactive_fg]" = "\"#d0164a\"";
  "theme[graph_text]" = "\"${palette.red}\"";
  "theme[meter_bg]" = "\"#500021\"";
  "theme[proc_misc]" = "\"${palette.text}\"";
  "theme[cpu_box]" = "\"${palette.text}\"";
  "theme[mem_box]" = "\"${palette.text}\"";
  "theme[net_box]" = "\"${palette.text}\"";
  "theme[proc_box]" = "\"${palette.text}\"";
  "theme[div_line]" = "\"${palette.text}\"";
  "theme[temp_start]" = "\"#d05376\"";
  "theme[temp_mid]" = "\"${palette.red}\"";
  "theme[temp_end]" = "\"${palette.text}\"";
  "theme[cpu_start]" = "\"#d05376\"";
  "theme[cpu_mid]" = "\"${palette.red}\"";
  "theme[cpu_end]" = "\"${palette.text}\"";
  "theme[free_start]" = "\"${palette.accentDark}\"";
  "theme[free_mid]" = "\"${palette.red}\"";
  "theme[free_end]" = "\"${palette.text}\"";
  "theme[cached_start]" = "\"${palette.accentDark}\"";
  "theme[cached_mid]" = "\"${palette.red}\"";
  "theme[cached_end]" = "\"${palette.text}\"";
  "theme[available_start]" = "\"${palette.accentDark}\"";
  "theme[available_mid]" = "\"${palette.red}\"";
  "theme[available_end]" = "\"${palette.text}\"";
  "theme[used_start]" = "\"${palette.accentDark}\"";
  "theme[used_mid]" = "\"${palette.red}\"";
  "theme[used_end]" = "\"${palette.text}\"";
  "theme[download_start]" = "\"${palette.accentDark}\"";
  "theme[download_mid]" = "\"${palette.red}\"";
  "theme[download_end]" = "\"${palette.text}\"";
  "theme[upload_start]" = "\"${palette.accentDark}\"";
  "theme[upload_mid]" = "\"${palette.red}\"";
  "theme[upload_end]" = "\"${palette.text}\"";
  "theme[process_start]" = "\"#f07598\"";
  "theme[process_mid]" = "\"${palette.red}\"";
  "theme[process_end]" = "\"${palette.text}\"";
}
