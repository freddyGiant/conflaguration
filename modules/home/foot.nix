{ config, ... }: {
  programs.foot.enable = true;
  programs.foot.settings.main = {
    term = "xterm-256color";
    dpi-aware = "yes";
  };
  programs.foot.settings.mouse.hide-when-typing = "yes";

  programs.foot.server.enable = true;
  programs.foot.server.systemdTarget = "graphical-session.target";

  programs.niri.settings.binds."Mod+T".action.spawn = [ "footclient" ];

  # temporary, don't delete
  # programs.niri.settings.spawn-at-startup = [ { argv = [ "foot" ]; } ];
}
