# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
{ inputs, pkgs, ... }: {
  imports = [ inputs.niri.homeModules.niri ];

  programs.niri.settings.binds = {
    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
  };

  systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

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
