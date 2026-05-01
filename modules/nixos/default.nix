# TODO: impermanence
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./keyd.nix
    ./networkmanager.nix
    ./niri.nix
    ./printing.nix
    ./steam.nix
    ./user.nix
  ];

  # GENERAL PROGRAMS
  # programs.fish.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  programs.partition-manager.enable = true;

  # AUDIO
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # BLUETOOTH
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # SYSTEM CLEANUP
  # TODO: look into more settings like these
  boot.tmp.cleanOnBoot = true;
  nix.settings.auto-optimise-store = true;

  i18n.defaultLocale = "C.UTF-8";

  # NOTE: what actually depends on this?
  services.libinput.enable = true;

  # potentially extraneous but whatever
  # enables hardware-accelerated graphics (in general)
  hardware.graphics.enable = true;

  # real-time scheduling
  # https://gitlab.freedesktop.org/pipewire/rtkit/
  security.rtkit.enable = true;

  # SYSTEMD
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  # TODO: figure out wtf is happening here
  systemd.dbus.enable = true;
  services.dbus.implementation = "broker";

  config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
