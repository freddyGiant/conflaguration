{
  imports = [
    ./bluetooth.nix
    ./fish.nix
    ./gimp.nix
    ./home-manager.nix
    ./keyd.nix
    ./networkmanager.nix
    ./niri.nix
    ./user.nix
  ];

  i18n.defaultLocale = "C.UTF-8";
  time.timeZone = secrets.timezone;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canToughEfiVariables = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
