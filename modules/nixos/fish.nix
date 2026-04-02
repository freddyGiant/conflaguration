{ pkgs, ... }: {
  programs.fish.enable = true;
  users.users.vrad.shell = pkgs.fish;
}
