{ pkgs, ... }: {
  programs.foot.enable = true;
  programs.foot.settings.main = {
    term = "xterm-256color";
    dpi-aware = "yes";
  };
  programs.foot.settings.mouse.hide-when-typing = "yes";

  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  programs.settings.main.font = "JetBrainsMono NFM:size=8";
}
