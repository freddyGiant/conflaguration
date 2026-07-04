# TODO: greeting
# TODO: prompt
# see discord screenshots lol
{ config, lib, ... }: {
  imports = [
    ./functions
    ./abbrs.nix
  ];

  # mkDefault b/c it has historically needed to be turned off elsewhere
  home.shell.enableFishIntegration = lib.mkDefault true;

  programs.fish = {
    enable = true;
    generateCompletions = true;
  };

  programs.foot.settings.main.shell = "${pkgs.fish}/bin/fish";

  # TODO: + bind (properly)
  # tried binding <TAB> to expand, but issues described below
  # consider just creating file directly

  # FIXME: strictly speaking, this should work in all modes, but that actually hits a nix limitation! hilarious.
  # programs.fish.binds = {
  #   # this option should really be a list instead of a set. maybe i can implement that directly
  #   tab = {
  #     # HACK: lmao home-manager quotes the command which doesn't support
  #     # combining them
  #     # see https://fishshell.com/docs/current/cmds/bind.html#special-input-functions
  #     command = "\\'expand-abbr or complete\\'";
  #     mode = "insert";
  #   };
  # };
}
