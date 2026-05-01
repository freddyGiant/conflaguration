{ config, ... }: {
  imports = [
    ./functions/
    ./abbrs.nix
  ];

  # # since this is a weird thing to do, it make sense for it to be an option
  # options = {
  #   my.fish.emitInitEnd = {
  #     type = lib.types.bool;
  #     default = true;
  #   };
  # };

  # mkDefault b/c it has historically needed to be turned off elsewhere
  home.shell.enableFishIntegration = lib.mkDefault true;

  programs.fish = {
    enable = true;
    generateCompletions = true;
  };

  # from https://wiki.nixos.org/wiki/Fish#Setting_fish_as_default_shell
  programs.bash.initExtra = /* bash */ ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';

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
