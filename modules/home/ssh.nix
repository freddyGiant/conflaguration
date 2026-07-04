{ config, lib, pkgs, ... }: {
  programs.ssh.enable = true;
  # stupid
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.settings."*" = {
    forwardAgent = false;
    hashKnownHosts = true;
    extraOptions.RequestTTY = "yes";

    controlMaster = "auto";
    controlPath = "${config.home.homeDirectory}/.ssh/sockets/%r_%h_%p";
    controlPersist = "10m";
    serverAliveInterval = 15;
    serverAliveCountMax = 3;
  };

  # by god, they fixed all of it.
  services.ssh-agent.enable = true;

  programs.fish.shellAbbrs.ssh = "ssh -S none";
  # M necessary?
  programs.fish.shellAbbrs.ssm = "ssh -MNTf";

  programs.keepassxc.settings.SSHAgent = {
    Enabled = true;
    UseOpenSSH = true;
  };
}
