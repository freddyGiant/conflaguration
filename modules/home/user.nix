{ config, lib, ... }: {
  options = {
    my.username = lib.mkOption {
      type = lib.types.strMatching "^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$";
      default = "vrad";
    };
  };

  config = {
    home.username = config.my.username;
  };
}
