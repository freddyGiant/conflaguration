{ config, lib, ... }: (lib.mkMerge [
  {
    programs.keepassxc.enable = true;
    programs.keepassxc.settings.General.BackupBeforeSave = true;
    programs.keepassxc.settings.GUI = {
      CompactMode = true;
      MinimizeToTray = true;
      MinimizeOnStartup = true;
      MinimizeOnClose = true;
      ShowTrayIcon = true;
    };
    # # incompatible with wayland as of 11-2025
    # Browser.Enabled = true;
    programs.keepassxc.settings.Security = {
      ClearClipboardTimeout = 120;
      LockDatabaseIdleSeconds = 1800;
      IconDownloadFallback = true;
    };
    # stubborn?
    programs.keepassxc.settings.FdoSecrets.Enable = true;

    systemd.user.services.keepassxc = {
      Unit = {
        Description = "Modern, open-source password manager";
        Documentation = "man:keepassxc(1}";

      }
      Install.WantedBy = [ "graphical.target" ];
    };
  }

  (lib.mkIf services.ssh-agent.enable {
    # requires that SSH_AUTH_SOCK be properly initialized; see ./ssh.nix
    programs.keepassxc.settings.SSHAgent = {
      Enabled = true;
      UseOpenSSH = true;
    };
    systemd.user.services.keepassxc.Unit = {
      Wants = [ "ssh-agent.service" ];
      After = [ "ssh-agent.service" ];
      ReloadPropagatedFrom = [ "ssh-agent.service" ];
    };
  })
])

