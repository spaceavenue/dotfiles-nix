{ pkgs, ... }:

{
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
      }
      {
        users = [ "sanya" ];
        runAs = "root";
        cmd = "/usr/bin/btrfs";
        args = [
          "qgroup"
          "show"
          "/"
        ];
        noPass = true;
      }
    ];
  };

  users.users.sanya = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
  };

  programs.fish.enable = true;
}
