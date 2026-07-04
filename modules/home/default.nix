# TODO: ghostty-neovim-yazi
{ lib, pkgs, ... }: {
  imports = [
    ./directories.nix
    ./direnv.nix
    ./fish
    ./fonts.nix
    ./foot.nix
    ./git.nix
    ./keepassxc.nix
    ./neovim
    ./niri.nix
    ./pipewire.nix
    ./ssh.nix
    # ./tex.nix
    ./trash.nix
    ./tree.nix
    ./waybar.nix
  ];

  home.username = lib.mkDefault "vrad";

  # NOTE: some of these don't really make sense on priveleged/remote machines.
  # worst case, they're just useless.
  # although, consider moving some to with wm?
  # TODO: think about this...
  home.packages = with pkgs; [
    man-pages

    # cli, or small utility
    brightnessctl
    killall
    # ncdu
    pavucontrol
    power-profiles-daemon
    # rnote
    # shotman
    wev
    wl-clipboard

    # system-config-printer

    # heavier, graphical
    kdePackages.dolphin
    # localsend
    # prismlauncher
    qalculate-qt
    # webcord
    # vlc
    # styluslabs-write
    # zoom-us
  ];

  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  # programs.tofi.enable = true;
  # programs.waybar.enable = true;

  # let home-manager enable/restart systemd services as appropriate
  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
  # ?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  home.stateVersion = "25.11";
}
