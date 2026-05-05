{ config, /* inputs, */ pkgs, ... }: {
  # imports = [ inputs.niri.nixosModules.niri ];
  # uncomment if we want to switch to sodiboo's more up-to-date binary cache
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  # programs.niri.package = pkgs.niri;
  # niri-flake.cache.enable = false;

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.niri.binPath = "${pkgs.niri}/bin/niri-session";

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config.common.default = "*";
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
