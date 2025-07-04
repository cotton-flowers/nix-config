# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "sdhci_acpi" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a3b42f7c-1c23-4b50-8d8b-1195fed053d2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E26C-2071";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/home/cotton/extra" =
    { device = "/dev/disk/by-uuid/d02bbe78-5f19-4665-8d84-38bf07bbdceb";
      fsType = "btrfs";
      options = [ "subvol=home/cotton/extra" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/d02bbe78-5f19-4665-8d84-38bf07bbdceb";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/83d99e5b-d888-4347-b7fa-09cd25bf5399"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
