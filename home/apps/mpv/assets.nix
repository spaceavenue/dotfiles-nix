{ pkgs }:

{
  scripts = {
    modernz = pkgs.fetchurl {
      name = "modernz.lua";
      url = "https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz.lua";
      sha256 = "0s12xm01rv2lmcaahj1rfc5hvgzyhmyzn5zx36qb781ii49jyqkg";
    };

    playlistmanager = pkgs.fetchurl {
      name = "playlistmanager.lua";
      url = "https://raw.githubusercontent.com/jonniek/mpv-playlistmanager/master/playlistmanager.lua";
      sha256 = "1gncm45wk7x1wqg63r45rxd6505fqp8qkavisj3wz9vkwafmqkn5";
    };

    autoload = pkgs.fetchurl {
      name = "autoload.lua";
      url = "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua";
      sha256 = "0i471m1ghi99ckd7rvdikhrxfs29201s852c8v9s1xi8r715mvy0";
    };

    acompressor = pkgs.fetchurl {
      name = "acompressor.lua";
      url = "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/acompressor.lua";
      sha256 = "0fa66gfxbgq3v41jkamrd3wk8ydy8w9vp233zh6s5ilbbs9wj9bx";
    };

    seekTo = pkgs.fetchurl {
      name = "seek-to.lua";
      url = "https://raw.githubusercontent.com/occivink/mpv-scripts/master/scripts/seek-to.lua";
      sha256 = "1q5zcv39p9xpb3frlzb1jp2hsxhwz6gxlr7h7lx0ghr409wj5dir";
    };

    webm = pkgs.fetchurl {
      name = "webm.lua";
      url = "https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua";
      sha256 = "1j1pn6s9xps96xnzlngwwnkmh43d20xyifhnmrm1l2h89fga8bgv";
    };
  };

  shaders = {
    ravuZoom = pkgs.fetchurl {
      name = "ravu-zoom-ar-r3-rgb.hook";
      url = "https://raw.githubusercontent.com/bjin/mpv-prescalers/master/ravu-zoom-ar-r3-rgb.hook";
      sha256 = "17wi1sgb0jwdrcxmkpkhdi9fi7d6xvzqcky3jmyfxxvzlajsyqij";
    };

    cflPrediction = pkgs.fetchurl {
      name = "CfL_Prediction.glsl";
      url = "https://raw.githubusercontent.com/Artoriuz/glsl-chroma-from-luma-prediction/main/CfL_Prediction.glsl";
      sha256 = "05mp2zrs471cigyj4bi1jrrr1jmd3z484nbb4vdxkd5sshw2vlgr";
    };

    jointBilateral = pkgs.fetchurl {
      name = "JointBilateral.glsl";
      url = "https://raw.githubusercontent.com/Artoriuz/glsl-joint-bilateral/main/JointBilateral.glsl";
      sha256 = "16cvanpyp5ymsv1mdi2nqgvd60x1zqz4axpafc819hsjr7p6bhby";
    };

    fastBilateral = pkgs.fetchurl {
      name = "FastBilateral.glsl";
      url = "https://raw.githubusercontent.com/Artoriuz/glsl-joint-bilateral/main/FastBilateral.glsl";
      sha256 = "0xqvz7wh9rlyspahhpcgi68zqmyhfy0ibwz904z5gcj100ii0yf0";
    };
  };

  fonts = {
    modernzIcons = pkgs.fetchurl {
      name = "modernz-icons.ttf";
      url = "https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz-icons.ttf";
      sha256 = "05m0c3n3g5bmn0cy842wv3p919xxb443pwn6d24m60lmar6vhcsh";
    };
  };
}
