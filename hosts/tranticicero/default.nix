{
  imports = [ ./hardware-configuration.nix ];

  # use systemd-boot's EFI bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canToughEfiVariables = true;
  };
}
