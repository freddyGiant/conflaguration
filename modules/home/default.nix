{ lib, pkgs, ... }: {
  imports = [
    ./directories.nix
    ./fish/
    ./git.nix
    ./keepassxc.nix
    ./neovim/
    ./ssh.nix
    ./tex.nix
    ./trash.nix
    ./tree.nix
  ];

  home.username = lib.mkDefault "vrad";

  home.packages = with pkgs; [
    ncdu
    killall
  ];

  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;

  # let home-manager enable/restart systemd services as appropriate
  systemd.user.startServices = "sd-switch";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
