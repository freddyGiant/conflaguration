{ config, pkgs, ... }: {
  programs.foot.enable = true;
  programs.foot.settings.main = {
    term = "xterm-256color";
    dpi-aware = "yes";
  };
  programs.foot.settings.mouse.hide-when-typing = "yes";

  programs.foot.server.enable = true;

  # programs.niri.settings.binds."Mod+T".action.spawn =
  #   if osConfig.programs.uwsm.enable or false then
  #     [ "uwsm" "app" "--" "footclient" ]
  #   else
  #     [ "footclient" ];

  programs.niri.settings.binds."Mod+T" =
    config.lib.niri.asUnit [ "footclient" ];
}
