{ config, lib, secret-settings, ... }: {
  options = {
    my.ssh.enableFishIntegration =
      lib.hm.shell.mkFishIntegrationOption { inherit config; };
  };

  config = {
    programs.ssh.enable = true;
    # stupid
    programs.ssh.enableDefaultConfig = false;
    programs.ssh.matchBlocks = {
      "*" = {
        forwardAgent = false;
        hashKnownHosts = true;
        extraOptions.RequestTTY = "yes";

        controlMaster = "auto";
        controlPath = "${final.home.homeDirectory}/.ssh/control/%r_%h_%p";
        controlPersist = "10m";
        serverAliveInterval = 15;
        serverAliveCountMax = 3;
      };
    };

    # NOTE: unfortunately, this adds a weird conditional to all your shell init scripts,
    # but it's pretty inconsequential. See the home-manager repo for more
    services.ssh-agent.enable = true;
    # TODO: SEE IF WE NEED THIS
    # TODO: darwin?
    # TODO: reccommend this change in nixpkgs?
    # systemd.user.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/${config.services.ssh-agent.socket}";

    # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/misc/ssh-auth-sock.nix#L26
    # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/services/ssh-agent.nix#L30

    programs.fish.shellAbbrs.shit = "ssh -t";
    # M necessary?
    programs.fish.shellAbbrs.shbg = "ssh -MNTf";
  };
}
