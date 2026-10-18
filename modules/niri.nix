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

{ config, moduleWithSystem, ... }:
let
  inherit (config) conflaguration;
in
{
  # share system niri from pkgs
  conflaguration.features.myDesktop.homeManager = moduleWithSystem (
    { pkgs, ... }:
    {
      wayland.windowManager.niri.enable = true;
      wayland.windowManager.niri.package = pkgs.niri;

      wayland.windowManager.niri.settings.prefer-no-csd = { };
      wayland.windowManager.niri.settings.binds = {
        "Mod+Shift+Slash".show-hotkey-overlay = { };
        "Ctrl+Alt+Delete".quit = { };
        # TODO: you know what
        # TODO: screenshot -> clipboard?
        Print.screenshot = { };
      };

      # TODO: move me to directories?
      wayland.windowManager.niri.settings.screenshot-path =
        "${config.xdg.userDirs.pictures}/screenshots/%Y-%m-%d_%H-%M-%S.png";

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config.common.default = "*";
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      # is this necessary?
      systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";
    }
  );

  conflaguration.features.myDesktop.nixos = moduleWithSystem (
    { pkgs, ... }: (
      { config, ... }:
      {
        programs.niri.enable = true;
        programs.niri.package = pkgs.niri;

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
      }
    )
  );
}
