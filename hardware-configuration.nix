{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."arch-linux" = {
    device = "/dev/disk/by-uuid/028375aa-2a4a-40f1-aa94-71b71d201a81";
    allowDiscards = true;
  };

  fileSystems."/" = {
    device = "/dev/mapper/arch-linux";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd:3" "noatime" "ssd" "space_cache=v2" "discard=async" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/arch-linux";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:3" "noatime" "ssd" "space_cache=v2" "discard=async" ];
  };

  fileSystems."/media" = {
    device = "/dev/disk/by-uuid/67a29e4c-7ec3-4d77-8a24-47877ef3a9bc";
    fsType = "btrfs";
    options = [ "subvol=@data" "compress=zstd:3" "noatime" "ssd" "space_cache=v2" "discard=async" ];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/arch-linux";
    fsType = "btrfs";
    options = [ "subvol=@swap" "noatime" ];
  };

  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/12F2-778E";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
