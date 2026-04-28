{
  imports = [
    ./bluetooth.nix
    ./fish.nix
    ./fonts.nix
    ./gimp.nix
    ./home-manager.nix
    ./keyd.nix
    ./localsend.nix
    # ./ly.nix
    ./networkmanager.nix
    ./niri.nix
    ./pipewire.nix
    ./printing.nix
    ./steam.nix
    ./user.nix
    ./xone.nix
  ];

  programs.partition-manager.enable = true;

  services.dbus.implementation = "broker";
  services.udisks2.enable = true;
  services.libinput.enable = true;
  services.lvm.enable = true;

  # potentially extraneous but whatever
  # enables hardware-accelerated graphics (in general)
  hardware.graphics.enable = true;

  # real-time scheduling
  # https://gitlab.freedesktop.org/pipewire/rtkit/
  security.rtkit.enable = true;

  i18n.defaultLocale = "C.UTF-8";
  # TODO: separate by machine
  time.timeZone = secret-settings.timezone;

  boot.loader.systemd-boot.enable = true;

  # TODO: look into more settings like these
  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
