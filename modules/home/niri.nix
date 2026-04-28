# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
{
  programs.niri.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
