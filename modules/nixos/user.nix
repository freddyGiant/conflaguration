{ config, lib, ... }: {
  options = {
    my.username = lib.mkOption {
      type = lib.types.strMatching "^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$";
      description = "My Unix username";
      default = "vrad";
    };
  };

  config = {
    users.users.${config.my.username} = {
      isNormalUser = true;
      group = config.my.username;
      extraGroups = [
        "wheel"
        "input"
        "audio"
        "video"
      ];
    };
    users.groups.${config.my.username} = { };

    # NOTE: consider users.users.<name>.cryptHomeLuks
    # here or in disk file

    security.sudo.extraRules = [
      {
        users = [ config.my.username ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
