{ config, lib, ... }: {
  keepassxc.settings.SSHAgent = lib.optionalAttrs config.programs.ssh.enable {
    Enabled = true;
    UseOpenSSH = true;
  };
}

