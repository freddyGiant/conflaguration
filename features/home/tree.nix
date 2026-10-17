{ pkgs, ... }: {
  home.packages = [ pkgs.tree ];

  programs.fish.shellAbbrs.tree = "tree -C";
}
