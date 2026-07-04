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
      controlPath = "${config.home.homeDirectory}/.ssh/sockets/%r_%h_%p";
      controlPersist = "10m";
      serverAliveInterval = 15;
      serverAliveCountMax = 3;
    };
  };

  programs.fish.shellAbbrs.ssh = "ssh -S none";
  # M necessary?
  programs.fish.shellAbbrs.ssm = "ssh -MNTf";

  # NOTE: unfortunately, this adds a weird conditional to all your shell init
  # scripts, but it's pretty inconsequential. See the home-manager repo for
  # more
  services.ssh-agent.enable = true;

  # TODO: darwin?
  # TODO: should it be like this in nixpkgs?
  #
  # from man:ssh-agent(1):
  # > The third way to run ssh-agent is via socket activation from a
  # > supervising process, such as systemd. In this mode, the supervising
  # > process creates the listening socket and is responsible for starting
  # > ssh-agent as needed, and also for communicating the location of the
  # > socket listener to other programs in the user's session.
  #
  # by default, the ssh-auth-sock home-manager module sets this through a shell
  # script but i prefer to do it this way (why depend on shell inits?)
  # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/misc/ssh-auth-sock.nix#L26
  # https://github.com/nix-community/home-manager/blob/8ec5a714dbbeb3fda00bd9758175555ebbad4d07/modules/services/ssh-agent.nix#L30
  systemd.user.services.ssh-agent.Service.ExecStartPost =
    lib.getExe (pkgs.writeShellApplication {
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
    });

  # requires that SSH_AUTH_SOCK be properly initialized; see ./ssh.nix
  programs.keepassxc.settings.SSHAgent = {
    Enabled = true;
    UseOpenSSH = true;
  };

  home.packages = [ pkgs.libnotify ];
  systemd.user.services."org.keepassxc.KeePassXC" =
    lib.mkIf config.my.keepassxc.asUnit 
    {
      Unit = {
        Wants = [ "ssh-agent.service" ];
        After = [ "ssh-agent.service" ];
        ReloadPropagatedFrom = [ "ssh-agent.service" ];
      };

      # warn in event of $SSH_AUTH_SOCK not being available
      # including escaped single quotes in single-quoted strings *in* double-single-quoted nix strings is... as bad as it sounds
      # https://nix.dev/manual/nix/2.26/language/string-literals
      Service.ExecStartPre = lib.getExe (pkgs.writeShellApplication {
        name = "keepassxc-check-ssh-auth-sock";
        text = /* bash */ ''
          # if string not empty, i.e. if var is set (to nonempty string)
          if [ -z "$SSH_AUTH_SOCK" ]; then
            ${pkgs.libnotify}/bin/notify-send --app-name=KeePassXC \
              'KeePassXC: SSH agent unavailable' \
              "SSH_AUTH_SOCK is not set. Keys can't be added."

            exit
          fi

          # if file at this dir exists (and is not some dummy file)
          if [ ! -S "$SSH_AUTH_SOCK" ]; then
            ${pkgs.libnotify}/bin/notify-send --app-name=KeePassXC \
              'KeePassXC: SSH agent unavailable' \
              "$SSH_AUTH_SOCK is not a valid socket. Keys can't be added."
          fi
        '';
      });
    };
}
