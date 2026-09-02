{ pkgs, ... }:

{
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    timeout = 0;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
  };

  chaotic.nyx.cache.enable = true;
  boot = {
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelParams = [
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
  };
}
