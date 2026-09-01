{
  General = {
    TabWidth = 4;
    Header = 0;
    AlternateRows = false;
    ColumnMode = false;
    LineNumMode = false;
    Wrap = "character";
    ColumnDelimiter = ",";
    MarkStyleWidth = 1;
    Prompt = {
      Normal = { };
      Input = { };
    };
    Style = {
      Alternate.Background = "#242438";
      ColumnHighlight = {
        Background = "#313244";
        Reverse = true;
      };
      ColumnRainbow = [
        { Foreground = "#cdd6f4"; }
        { Foreground = "#ffd1db"; }
        { Foreground = "#f38ba8"; }
        { Foreground = "#cba6f7"; }
        { Foreground = "#89b4fa"; }
        { Foreground = "#a6e3a1"; }
        { Foreground = "#fab387"; }
      ];
      Header = {
        Foreground = "#ffd1db";
        Bold = true;
      };
      HeaderBorder = {
        Foreground = "#cba6f7";
        Underline = true;
      };
      JumpTargetLine = {
        Foreground = "#f38ba8";
        Underline = true;
        Bold = true;
      };
      LineNumber = {
        Foreground = "#7f849c";
        Bold = true;
      };
      MarkLine = {
        Foreground = "#ffd1db";
        Background = "#313244";
        Bold = true;
      };
      MultiColorHighlight = [
        { Foreground = "#ffd1db"; Bold = true; }
        { Foreground = "#f38ba8"; Bold = true; }
        { Foreground = "#cba6f7"; Bold = true; }
        { Foreground = "#89b4fa"; }
        { Foreground = "#a6e3a1"; }
        { Foreground = "#fab387"; }
        { Foreground = "#94e2d5"; }
      ];
      Ruler = {
        Foreground = "#9399b2";
        Background = "#313244";
        Bold = true;
      };
      SearchHighlight = {
        Foreground = "#cdd6f4";
        Background = "#3e5767";
        Bold = true;
        Reverse = true;
      };
      SectionLine = {
        Foreground = "#cba6f7";
        Background = "#313244";
        Bold = true;
      };
      LeftStatus = {
        Foreground = "#1e1e2e";
        Background = "#cba6f7";
        Bold = true;
      };
      RightStatus = {
        Foreground = "#cdd6f4";
        Background = "#313244";
      };
    };
  };

  StyleOverStrike.Bold = true;
  StyleOverLine.Underline = true;

  KeyBind = {
    align_format = [ "alt+f" ];
    alter_rows_mode = [ "C" ];
    backsearch = [ "?" ];
    begin_left = [ "shift+Home" ];
    bottom = [ "End" ];
    cancel = [ "ctrl+c" ];
    close_all_filter = [ "K" ];
    close_doc = [ "ctrl+k" ];
    close_file = [ "ctrl+F9" "ctrl+alt+s" ];
    column_mode = [ "c" ];
    column_width = [ "alt+o" ];
    convert_type = [ "alt+t" ];
    delimiter = [ "d" ];
    down = [ "Enter" "Down" "ctrl+n" ];
    edit = [ "alt+v" ];
    end_right = [ "shift+End" ];
    exit = [ "Escape" "q" ];
    filter = [ "&" ];
    fixed_column = [ "F" ];
    follow_all = [ "ctrl+a" ];
    follow_mode = [ "ctrl+f" ];
    follow_section = [ "F2" ];
    goto = [ "g" ];
    half_left = [ "ctrl+left" ];
    half_right = [ "ctrl+right" ];
    header = [ "H" ];
    header_column = [ "Y" ];
    help = [ "h" "ctrl+F1" "ctrl+alt+c" ];
    hide_other = [ "alt+-" ];
    input_casesensitive = [ "alt+c" ];
    input_copy = [ "ctrl+c" ];
    input_incsearch = [ "alt+i" ];
    input_next = [ "Down" ];
    input_non_match = [ "!" ];
    input_paste = [ "ctrl+v" ];
    input_previous = [ "Up" ];
    input_regexp_search = [ "alt+r" ];
    input_smart_casesensitive = [ "alt+s" ];
    jump_target = [ "j" ];
    last_section = [ "9" ];
    left = [ "left" ];
    line_number_mode = [ "G" ];
    logdoc = [ "ctrl+F2" "ctrl+alt+e" ];
    mark = [ "m" ];
    mark_by_pattern = [ "*" ];
    mark_number = [ "," ];
    multi_color = [ "." ];
    next_backsearch = [ "N" ];
    next_doc = [ "]" ];
    next_mark = [ ">" ];
    next_search = [ "n" ];
    next_section = [ "space" ];
    page_down = [ "PageDown" "ctrl+v" ];
    page_half_down = [ "ctrl+d" ];
    page_half_up = [ "ctrl+u" ];
    page_up = [ "PageUp" "ctrl+b" ];
    plain_mode = [ "ctrl+e" ];
    previous_doc = [ "[" ];
    previous_mark = [ "<" ];
    previous_section = [ "^" ];
    rainbow_mode = [ "ctrl+r" ];
    raw_format = [ "alt+r" ];
    reload = [ "F5" "ctrl+alt+l" ];
    remove_all_mark = [ "ctrl+delete" ];
    remove_mark = [ "M" ];
    right = [ "right" ];
    right_align = [ "alt+a" ];
    save_buffer = [ "S" ];
    search = [ "/" ];
    section_delimiter = [ "alt+d" ];
    section_header_num = [ "F7" ];
    section_start = [ "ctrl+F3" "alt+s" ];
    set_view_mode = [ "p" "P" ];
    set_write_exit = [ "ctrl+q" ];
    shrink_column = [ "s" ];
    sidebar_doc_list = [ "alt+l" ];
    sidebar_down = [ "shift+Down" ];
    sidebar_help = [ "alt+h" ];
    sidebar_left = [ "shift+Left" ];
    sidebar_marks = [ "alt+m" ];
    sidebar_right = [ "shift+Right" ];
    sidebar_sections = [ "alt+u" ];
    sidebar_styles = [ "alt+y" ];
    sidebar_up = [ "shift+Up" ];
    skip_lines = [ "ctrl+s" ];
    status_line = [ "ctrl+F10" ];
    style_toggle = [ "o" ];
    suspend = [ "ctrl+z" ];
    sync = [ "ctrl+l" ];
    tabwidth = [ "t" ];
    toggle_mouse = [ "ctrl+F8" "ctrl+alt+r" ];
    toggle_ruler = [ "alt+shift+F9" ];
    top = [ "Home" ];
    up = [ "Up" "ctrl+p" ];
    vertical_header = [ "y" ];
    watch = [ "F4" "ctrl+alt+w" ];
    watch_interval = [ "ctrl+w" ];
    width_left = [ "alt+left" ];
    width_right = [ "alt+right" ];
    word_wrap_mode = [ "alt+w" ];
    wrap_mode = [ "w" "W" ];
    write_exit = [ "Q" ];
    write_original = [ "alt+shift+F8" ];
  };

  Mode = {
    markdown = {
      SectionDelimiter = "^#";
      Wrap = "word";
      Style.SectionLine.Background = "blue";
    };
    psql = {
      Header = 2;
      AlternateRows = true;
      ColumnMode = true;
      LineNumMode = false;
      Wrap = "character";
      ColumnDelimiter = "|";
    };
    mysql = {
      Header = 3;
      AlternateRows = true;
      ColumnMode = true;
      LineNumMode = false;
      Wrap = "character";
      ColumnDelimiter = "|";
    };
    ps = {
      Header = 1;
      ColumnMode = true;
      ColumnRainbow = true;
      ColumnWidth = true;
      Wrap = "none";
    };
  };
}
