# unlimited powaaaaaaaahhhhhhh
{ pkgs, ... }:

{
  boot.extraModprobeConfig = ''
    options thinkpad_acpi fan_control=1
    options snd_hda_intel power_save=0
  '';

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
}
