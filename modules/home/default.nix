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

  # NOTE: some of these don't really make sense on priveleged/remote machines.
  # worst case, they're just useless.
  home.packages = with pkgs; [
    # cli, or small utility
    brightnessctl
    killall
    ncdu
    pavucontrol
    # rnote
    shotman
    wev
    wl-clipboard

    # heavier, graphical
    kdePackages.dolphin
    localsend
    prismlauncher
    qalculate-qt
    # also remove electron from flake.nix > permittedInsecurePackages
    webcord
    vlc
    styluslabs-write
    zoom-us
  ];

  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.tofi  .enable = true;
  programs.waybar.enable = true;

  # let home-manager enable/restart systemd services as appropriate
  systemd.user.startServices = "sd-switch";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
