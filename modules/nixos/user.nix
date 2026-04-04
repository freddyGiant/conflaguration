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
      extraGroups = [ "wheel" "input" "audio" "video" ];
    };

    sudo.extraRules = [{
      users = [ config.my.username ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };
}
