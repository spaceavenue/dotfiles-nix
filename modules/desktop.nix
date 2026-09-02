{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri-custom;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.greetd}/bin/agreety --cmd niri-session";
      initial_session = {
        command = "niri-session";
        user = "sanya";
      };
    };
  };

  xdg.portal.enable = true;
}
