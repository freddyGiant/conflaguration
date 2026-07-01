{ config, lib, ... }: {
  options = {
    my.username = lib.mkOption {
      type = lib.types.strMatching "^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$";
      default = "vrad";
    };
  };

  config = {
    users.users.${config.my.username} = {
      isNormalUser = true;
      password = "test";
      group = config.my.username;
      extraGroups = [ "wheel" "input" "audio" "video" ];
      # hashedPassword = null;
      # hashedPasswordFile = null;
      # initialPassword = "test";
    };
    users.groups.${config.my.username} = {};
    users.mutableUsers = false;

    # users.users.${config.my.username} = {
    #   isNormalUser = true;
    #   extraGroups = [ "wheel" "input" "audio" "video" ];
    # NOTE: consider users.users.<name>.cryptHomeLuks
    # here or in disk file
    # };

    security.sudo.extraRules = [{
      users = [ config.my.username ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };
}
