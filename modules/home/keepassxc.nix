{ config, lib, ... }: {
  programs.keepassxc.enable = true;
  programs.keepassxc.settings.General.BackupBeforeSave = true;
  programs.keepassxc.settings.GUI = {
    CompactMode = true;
    MinimizeToTray = true;
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
  programs.keepassxc.settings.FdoSecrets.Enable = true;
  programs.keepassxc.settings.SSHAgent = lib.optionalAttrs
    config.programs.ssh.enable
    {
      Enabled = true;
      UseOpenSSH = true;
    };
}

