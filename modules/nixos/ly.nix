{ config, ... }: {
  services.displayManager.ly.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = config.my.username;
  };
}
