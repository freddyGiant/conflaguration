{ config, lib, pkgs, ... }: (lib.mkMerge [
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

    systemd.user.services."org.keepassxc.KeePassXC" = {
      Unit = {
        Description = "Modern, open-source password manager";
        Documentation = "man:keepassxc(1}";
      };
      Service = {
        ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  }

  (lib.mkIf config.services.ssh-agent.enable {
    # requires that SSH_AUTH_SOCK be properly initialized; see ./ssh.nix
    programs.keepassxc.settings.SSHAgent = {
      Enabled = true;
      UseOpenSSH = true;
    };

    home.packages = [ pkgs.libnotify ];
    systemd.user.services."org.keepassxc.KeePassXC" = {
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
  })
])

