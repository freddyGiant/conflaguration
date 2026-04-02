{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canToughEfiVariables = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
};
