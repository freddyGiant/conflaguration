# NOTE: niri hardly benefits from UWSM at all.
# In systemd mode (e.g. launched with `niri-session`), it already wraps any
# launch commands as proper systemd units.
# Otherwise, if you want proper daemons and control, write a systemd service.
{ config, /* inputs, */ pkgs, ... }: {
  # imports = [ inputs.niri.nixosModules.niri ];
  # uncomment if we want to switch to sodiboo's more up-to-date binary cache
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  # programs.niri.package = pkgs.niri;
  # niri-flake.cache.enable = false;

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
