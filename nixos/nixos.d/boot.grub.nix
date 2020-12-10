{
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  boot = {
    loader.grub = {
      efiInstallAsRemovable = true;
      devices = ["nodev"];
      enable = true;
      version = 2;
      useOSProber = true;
      efiSupport = true;
    };
    loader.efi.canTouchEfiVariables = false;
  };
}
