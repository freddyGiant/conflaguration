{ config, ... }: {
  imports = [ ./hardware-configuration.nix ];

  logind.settings.Login.HandlePowerKey = "ignore";

  boot.initrd.systemd.enable = true;
  # TODO: figure out wtf is happening here
  systemd.dbus.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  # where did these come from? don't remember
  boot.initrd.availableKernelModules = [
    "ahci" "ehci_pci" "sdhci_pci" "rtsx_pci_sdmmc"
    "sd_mod" "usb_storage"
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # NECESSARY FOR ENCRYPTION

  boot.initrd.kernelModules = [ "cryptd" ];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NIXOS_LUKS";
  # IT'S IMPORTANT that this option only be set on LUKS-encrypted machines
  services.getty.autologinUser = config.my.username;

  # === NO MAN'S LAND ===

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  hardware.enableAllFirmware = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
