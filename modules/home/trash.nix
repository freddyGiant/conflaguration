{ pkgs, ... }: {
  home.packages = [ pkgs.trash-cli ];

  programs.fish.shellAbbrs.jk  = "trash -r -i";
}
