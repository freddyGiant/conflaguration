# TODO: prioritize networks (secret?)
{ config, pkgs, ... }: {
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    plugins = [ pkgs.networkmanager-openconnect ];
  };

  users.users.${config.my.username}.extraGroups = [ "networkmanager" ];
}
