# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
# top ten least favorite nix syntax choices
{ inputs, pkgs, ... }: {
  imports = [ inputs.niri.homeModules.niri ];
  programs.niri.settings.binds = {
    "Mod+Shift+Slash".action.show-hotkey-overlay = [];
  };

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";

  # TODO: clip to geometry for ff
  # TODO: xdg-desktop-portal-gtk: implements most of the basic functionality, this is the "default fallback portal".
  # TODO: xdg-desktop-portal-gnome: required for screencasting support.
  # TODO: gnome-keyring
  # TODO: mako
  # TODO: xwayland args for steam
  # TODO: plasma-polkit
  # TODO: sway migration
  # TODO: gamescope??
}
