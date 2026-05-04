{
  programs.git = {
    enable = true;

    settings = {
      # TODO: external diff/merge tools? integrate with nvim?
      # TODO: should this change?
      user.name = "freddyGiant";

      core = {
        # recall that this should be true for Windows users
        autocrlf = "input";
        whitespace = "tab-in-indent";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      advice.detachedHead = false;

      # safe.directory = "/etc/nixos";
    };

    ignores = [
      "vrad.*"
      ".DS_Store"
    ];
  };

  # TODO: cleaner?
  # programs.fish.shellAbbrs.g = "git";
  programs.fish.shellAbbrs = {
    g = "git";
  } // (builtins.mapAttrs (_: expansion: {
    command = "git";
    inherit expansion;
  }) {
    a   = "add";
    br  = "branch";
    cm  = "commit --message";
    cma = "commit --all --message";
    co  = "checkout";
    d   = "diff";
    fe  = "fetch";
    l   = "log --all --graph --oneline --decorate-refs-exclude='refs/remotes/origin'";
    mg  = "merge --no-ff";
    rv  = "revert --no-commit";
    st  = "status";
    sw  = "switch";
  });
}
