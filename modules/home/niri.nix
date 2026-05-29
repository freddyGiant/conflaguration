# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
# top ten least favorite nix syntax choices
{ inputs, lib, osConfig ? {}, pkgs, ... }: {
  imports = [ inputs.niri.homeModules.niri ];

  programs.niri.settings.binds = {
    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
  };

  programs.bash.enable = true; # lol
  # if we started supporting other display managers at the same time (not sure why we would do this) we could make an option for a general uwsm script(??)
  programs.bash.profileExtra = lib.mkAfter (if
    (osConfig.programs.uwsm.waylandCompositors or {}) ? niri
  then
    /* bash */ ''
      if uwsm check may-start; then
        exec uwsm start niri-uwsm.desktop
      fi
    ''
  else
    # is this really the behavior we want?
    /* bash */ ''
      if command -v uwsm; then
        if uwsm check may-start && uwsm select; then
          exec uwsm start default
        fi
      else
        exec niri-session
      fi
    '');

  # programs.bash.profileExtra = /* bash */ ''
  #   if command -v uwsm; then
  #     if uwsm check may-start && uwsm select; then
  #       exec uwsm start default
  #     fi
  #   else
  #     exec niri-session
  #   fi
  # '';

  systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
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
