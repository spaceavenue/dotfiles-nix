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

  programs.fish = {
    enable = true;
    # fenv (foreign-env fish plugin) forks a bash-interactive process at every
    # shell startup to source /etc/fish/{setEnvironment,foreign-env/*}.
    # increases startup by ~29ms, so its gotta go.
    # babelfish translates those scripts to fish at build time, so only a .fish
    # file gets sourced.
    useBabelfish = true;
  };
}
