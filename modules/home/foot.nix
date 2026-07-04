{ config, pkgs, ... }: {
  programs.foot.enable = true;
  programs.foot.settings.main = {
    term = "xterm-256color";
    dpi-aware = "yes";
  };
  programs.foot.settings.main.shell = "${pkgs.fish}";
  programs.foot.settings.mouse.hide-when-typing = "yes";

  programs.foot.server.enable = true;

  programs.niri.settings.binds."Mod+T".action.spawn = [ "footclient" ];
}
