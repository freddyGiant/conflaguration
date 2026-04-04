{
  imports = [
    ./directories.nix
    ./fish/
    ./git.nix
    ./keepassxc.nix
    ./ssh.nix
  ];

  home.username = "vrad";

  # let home-manager enable/restart systemd services as appropriate
  systemd.user.startServices = "sd-switch";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
