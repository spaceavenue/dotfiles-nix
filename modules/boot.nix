{ config, pkgs, lib, ... }:

{
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.timeout = 0;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.zpool=zsmalloc"
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "bgrt_disable"
    "nowatchdog"
    "systemd.getty_auto=no"
    "systemd.tpm2_pcrs=no"
  ];
}
