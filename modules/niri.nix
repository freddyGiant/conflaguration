# https://github.com/sodiboo/niri-flake/blob/main/docs.md
# https://github.com/sodiboo/niri-flake?tab=readme-ov-file
#
# NOTE: niri hardly benefits from UWSM at all.
# In systemd mode (e.g. launched with `niri-session`), it already wraps any
# launch commands as proper systemd units.
# Otherwise, if you want proper daemons and control, write a systemd service.
#
# TODO:
# - clip to geometry for ff
# - xdg-desktop-portal-gtk: implements most of the basic functionality, this is the "default fallback portal".
# - xdg-desktop-portal-gnome: required for screencasting support.
# - gnome-keyring
# - mako
# - xwayland args for steam
# - plasma-polkit
# - sway migration
# - gamescope??
# - window swallowing

{ config, inputs, ... }:
let
  inherit (config) conflaguration;
in
{
  conflaguration.features.myDesktop.homeManager =
  { pkgs, ... }:
  {
    imports = [ inputs.niri.homeModules.niri ];
    # FIXME: flake version unmaintained, dependency out of date! uh oh
    programs.niri.package = pkgs.niri;
    programs.niri.enable = true;

    programs.niri.settings.prefer-no-csd = true;
    programs.niri.settings.binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
      "Ctrl+Alt+Delete".action.quit = [ ];
      # TODO: you know what
      # TODO: screenshot -> clipboard?
      Print.action.screenshot = [ ];
    };

    # TODO: move me to directories?
    programs.niri.settings.screenshot-path =
      "${config.xdg.userDirs.pictures}/screenshots/%Y-%m-%d_%H-%M-%S.png";



    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  conflaguration.features.myDesktop.nixos =
  { config, ... }:
  {
    programs.niri.enable = true;

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = conflaguration.username;
      };
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
