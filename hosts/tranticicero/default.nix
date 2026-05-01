# TODO: Add disko
{ config, ... }: {
  imports = [ ./hardware-configuration.nix ];

  logind.settings.Login.HandlePowerKey = "ignore";

  boot.loader.efi.canTouchEfiVariables = true;
  # where did these come from? don't remember
  boot.initrd.availableKernelModules = [
    "ahci" "ehci_pci" "sdhci_pci" "rtsx_pci_sdmmc"
    "sd_mod" "usb_storage"
  ];

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # DISK ENCRYPTION

  boot.initrd.kernelModules = [ "cryptd" ]; # see above?
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";
  services.lvm.enable = true;
  services.udisks2.enable = true; # TODO: what depends on this again?
  # IT'S IMPORTANT that this option only be set on LUKS-encrypted machines
  services.getty.autologinUser = config.my.username;

  # NOTE: reconsider when using systemd-networkd on servers?
  networking.useDHCP = lib.mkDefault true;

  hardware.enableAllFirmware = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
