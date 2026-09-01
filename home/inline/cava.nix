{
  general = {
    framerate = "60";
    autosens = "1";
    sensitivity = "120";
    bars = "0";
    bar_width = "3";
    bar_spacing = "1";
    lower_cutoff_freq = "50";
    higher_cutoff_freq = "20000";
  };

  input = {
    method = "pipewire";
    source = "auto";
  };

  output = {
    method = "ncurses";
    channels = "stereo";
    mono_option = "average";
    data_format = "binary";
    bit_format = "16bit";
  };

  color = {
    gradient = "1";
    gradient_count = "3";
    gradient_color_1 = "'#720034'";
    gradient_color_2 = "'#f38ba8'";
    gradient_color_3 = "'#ffd1db'";
  };

  smoothing = {
    noise_reduction = "60";
    gravity = "100";
    integral = "50";
    monstercat = "0";
    waves = "0";
  };

  eq = {
    "1" = "1";
    "2" = "1";
    "3" = "1";
    "4" = "1";
    "5" = "1";
  };
}
