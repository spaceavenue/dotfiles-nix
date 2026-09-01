{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.max-jobs = 3;
  time.timeZone = "Asia/Kolkata";

  nixpkgs.config.allowUnfree = true;  
  networking.hostName = "nyx";

  boot.blacklistedKernelModules = [ "sp5100-tco" ];
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
    options snd_hda_intel power_save=0
  '';

  documentation.man.man-db.enable = false;
  documentation.man.mandoc.enable = true;

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; persist = true; }
      { users = [ "sanya" ]; runAs = "root"; cmd = "/usr/bin/btrfs"; args = [ "qgroup" "show" "/" ]; noPass = true; }
    ];
  };

  users.users.sanya = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "input" ];
  };

  programs.fish.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri-custom;
  };
  programs.steam.enable = true;
  
  fonts.enableDefaultPackages = false;
  fonts.packages = [ pkgs.ttf-ibm-plex-custom pkgs.ttc-iosevka-collection pkgs.nerd-fonts.symbols-only ];


  environment.systemPackages = with pkgs; [
    claude-code
    duf
    dust
    fd
    ffmpeg
    ffmpegthumbnailer
    fzf
    git
    delta
    github-cli
    glow
    hyperfine
    imagemagick
    kid3
    lazygit
    libqalculate
    ntfs3g
    openssh
    ouch
    oxipng
    pavucontrol
    perlPackages.ImageExifTool
    playerctl
    powertop
    sd
    smartmontools
    trash-cli
    umu-launcher
    vulkan-tools
    wev
    wf-recorder
    which
    xeyes
    xwayland-satellite
    zoxide
    rustup
    fish
    gnupg
    libnotify
    efibootmgr
    pinentry-curses
    twemoji-color-font
    clang-mold
    # custom packages
    imv-custom
    wtype-custom
    swaylock-time
    niri-custom
    qoz
    ttf-ibm-plex-custom
    ttc-iosevka-collection
  ];

  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - ${pkgs.bashInteractive}/bin/bash"
  ];

  system.stateVersion = "26.05";
}
