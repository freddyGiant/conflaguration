{ config, lib, pkgs, ... }: {
  # options = {
  #   my.ssh.enableFishIntegration =
  #     lib.hm.shell.mkFishIntegrationOption { inherit config; };
  # };

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

  # NOTE: unfortunately, this adds a weird conditional to all your shell init
  # scripts, but it's pretty inconsequential. See the home-manager repo for
  # more
  services.ssh-agent.enable = true;
  # TODO: darwin?
  # TODO: should it be like this in nixpkgs?
  # from man:ssh-agent(1):
  # > The third way to run ssh-agent is via socket activation from a
  # > supervising process, such as systemd. In this mode, the supervising
  # > process creates the listening socket and is responsible for starting
  # > ssh-agent as needed, and also for communicating the location of the
  # > socket listener to other programs in the user's session.
  # by default, the ssh-auth-sock home-manager module sets this through a shell
  # script but i prefer to do it this way (why depend on shell inits?)
  # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/misc/ssh-auth-sock.nix#L26
  # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/services/ssh-agent.nix#L30
  systemd.user.services.ssh-agent.Service.ExecStartPost =
    lib.getExe lib.writeShellApplication {
      name = "systemd-ssh-auth-sock";
      # composed from ssh-agent, ssh-auth-sock modules and with other
      # references for systemd unit configuration
      text = let
        inherit (config.services.ssh-agent) socket;
      in /* bash */ ''
        if [ -z "$SSH_AUTH_SOCK" ] || [ -z "$SSH_CONNECTION" ]; then
          systemctl --user --set-environment \
            SSH_AUTH_SOCK=/run/user/"$(id -u)"/${socket}
        fi
      '';
    };

  programs.fish.shellAbbrs.shit = "ssh -t";
  # M necessary?
  programs.fish.shellAbbrs.shbg = "ssh -MNTf";
}
