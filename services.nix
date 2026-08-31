
{ config, pkgs, ... }:
{
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
  networking.useDHCP = false;

  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = "127.0.0.1";
      interface = "lo";
      bind-interfaces = true;
      no-resolv = true;
      server = [ "9.9.9.9" "1.1.1.1" ];
      cache-size = 10000;
    };
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.speechd.enable = false;
  services.gnome.gnome-keyring.enable = false;
  services.udisks2.enable = true;

  security.rtkit.enable = false;

  xdg.portal = {
    enable = true;
  };

  systemd.services.power-manage = {
    description = "Apply ThinkPad Boot Power Settings";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.fish}/bin/fish /home/sanya/.local/bin/power-manage.fish boot";
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ACTION=="add|change", RUN+="${pkgs.fish}/bin/fish /home/sanya/.local/bin/power-manage.fish boot"
  '';

  system.stateVersion = "26.05";
}
