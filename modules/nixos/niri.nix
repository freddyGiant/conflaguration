# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
{ config, inputs, pkgs, ... }: {
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  # niri-flake.cache.enable = false;

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.niri.binPath = "${pkgs.niri}/bin/niri-session";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
