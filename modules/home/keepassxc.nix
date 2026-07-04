{ config, lib, pkgs, ... }: {
  options.my.keepassxc.asUnit = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    programs.keepassxc.enable = true;
    programs.keepassxc.settings.General.BackupBeforeSave = true;
    programs.keepassxc.settings.GUI = {
      CompactMode = true;
      MinimizeToTray = true;
      MinimizeOnStartup = true;
      MinimizeOnClose = true;
      ShowTrayIcon = true;
    };
    programs.keepassxc.settings.Security = {
      ClearClipboardTimeout = 120;
      LockDatabaseIdleSeconds = 1800;
      IconDownloadFallback = true;
    };
    # # incompatible with wayland as of 11-2025
    # programs.keepassxc.settings.Browser.Enabled = true;
    # https://github.com/nix-community/home-manager/blob/feda41500ec53fcd4e3131de7b0441bce08fd3e9/modules/programs/keepassxc.nix#L24
    programs.keepassxc.settings.Browser.UpdateBinaryPath = false;
    # stubborn?
    programs.keepassxc.settings.FdoSecrets.Enable = true;

    systemd.user.services."org.keepassxc.KeePassXC" =
      lib.mkIf config.my.keepassxc.asUnit 
      {
        Unit = {
          Description = "Modern, open-source password manager";
          Documentation = "man:keepassxc(1)";
        };
        Service = {
          ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
          Restart = "on-failure";
          RestartSec = 2;
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
  };
}

