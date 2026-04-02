{ pkgs, ... }: {
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    plugins = [ pkgs.networkmanager-openconnect ];
  };

  users.users.vrad.extraGroups = [ "networkmanager" ];
}
