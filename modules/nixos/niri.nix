{ niri, ... }: {
  nixpkgs.overlays = [ niri.overlays.niri ];

  programs.niri.enable = true;
}
