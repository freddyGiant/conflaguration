{ niri, ... }: {
  nixpkgs.overlays = [ niri.overlays.niri ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.niri.enable = true;
}
