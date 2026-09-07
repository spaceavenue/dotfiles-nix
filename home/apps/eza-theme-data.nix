let
  palette = import ../lib/palette.nix;
in
{
  colourful = true;

  filekinds = {
    normal = {
      foreground = palette.salmon;
    };
    directory = {
      foreground = palette.text;
    };
    symlink = {
      foreground = palette.blue;
    };

    block_device = {
      foreground = palette.red;
    };
    char_device = {
      foreground = palette.red;
    };

    pipe = {
      foreground = palette.mauve;
    };
    socket = {
      foreground = palette.mauve;
    };

    executable = {
      foreground = palette.peach;
    };

    mount_point = {
      foreground = "#ababff";
    };
    special = {
      foreground = palette.muted;
    };
  };

  file_type = {
    image = {
      foreground = palette.text;
    };
    video = {
      foreground = palette.red;
    };

    music = {
      foreground = palette.mauve;
    };
    lossless = {
      foreground = palette.mauve;
    };

    document = {
      foreground = palette.blue;
    };
    compressed = {
      foreground = palette.blue;
    };

    crypto = {
      foreground = palette.muted;
    };
    temp = {
      foreground = palette.muted;
    };

    compiled = {
      foreground = palette.green;
    };
    source = {
      foreground = palette.maroon;
    };
  };

  perms = {
    user_read = {
      foreground = palette.mauve;
      is_bold = true;
    };
    group_read = {
      foreground = "#b8a1e0";
    };
    other_read = {
      foreground = "#9a8bc4";
    };

    user_write = {
      foreground = palette.red;
      is_bold = true;
    };
    group_write = {
      foreground = "#eb7a95";
    };
    other_write = {
      foreground = "#d4708a";
    };

    user_execute_file = {
      foreground = palette.blue;
      is_bold = true;
    };
    user_execute_other = {
      foreground = palette.blue;
      is_bold = true;
    };
    group_execute = {
      foreground = "#7aa3e0";
    };
    other_execute = {
      foreground = "#6b93cc";
    };

    special_user_file = {
      foreground = palette.pink;
    };
    special_other = {
      foreground = palette.blue;
    };
    attribute = {
      foreground = palette.muted;
    };
  };

  size = {
    major = {
      foreground = palette.subtext;
    };
    minor = {
      foreground = palette.blue;
    };

    number_byte = {
      foreground = palette.red;
    };
    number_kilo = {
      foreground = palette.red;
    };
    number_mega = {
      foreground = palette.red;
    };
    number_giga = {
      foreground = palette.mauve;
    };
    number_huge = {
      foreground = palette.mauve;
    };

    unit_byte = {
      foreground = palette.red;
    };
    unit_kilo = {
      foreground = palette.red;
    };
    unit_mega = {
      foreground = palette.red;
    };
    unit_giga = {
      foreground = palette.mauve;
    };
    unit_huge = {
      foreground = palette.mauve;
    };
  };

  users = {
    user_you = {
      foreground = palette.pink;
    };
    user_root = {
      foreground = palette.red;
    };
    user_other = {
      foreground = palette.blue;
    };

    group_yours = {
      foreground = palette.pink;
    };
    group_root = {
      foreground = palette.red;
    };
    group_other = {
      foreground = palette.blue;
    };
  };

  links = {
    normal = {
      foreground = palette.blue;
    };
    multi_link_file = {
      foreground = palette.mauve;
    };
  };

  git = {
    new = {
      foreground = palette.green;
    };
    modified = {
      foreground = palette.peach;
    };
    deleted = {
      foreground = palette.red;
    };
    renamed = {
      foreground = palette.blue;
    };
    typechange = {
      foreground = palette.mauve;
    };
    ignored = {
      foreground = palette.muted;
    };
    conflicted = {
      foreground = palette.red;
      is_bold = true;
    };
  };

  git_repo = {
    branch_main = {
      foreground = palette.text;
    };
    branch_other = {
      foreground = palette.mauve;
    };
    git_clean = {
      foreground = palette.green;
    };
    git_dirty = {
      foreground = palette.red;
    };
  };

  security_context = {
    colon = {
      foreground = palette.muted;
    };
    user = {
      foreground = palette.text;
    };
    role = {
      foreground = palette.mauve;
    };
    typ = {
      foreground = palette.overlay1;
    };
    range = {
      foreground = palette.pink;
    };
  };

  header = {
    foreground = palette.mauve;
  };
  date = {
    foreground = "#ddaabb";
  };
  punctuation = {
    foreground = palette.muted;
  };
  inode = {
    foreground = palette.muted;
  };
  blocks = {
    foreground = palette.muted;
  };
  octal = {
    foreground = palette.red;
  };
  flags = {
    foreground = palette.blue;
  };

  symlink_path = {
    foreground = palette.blue;
  };
  control_char = {
    foreground = palette.text;
  };
  broken_symlink = {
    foreground = palette.red;
  };
  broken_path_overlay = {
    foreground = palette.muted;
  };
}
