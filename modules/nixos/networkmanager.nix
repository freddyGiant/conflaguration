{ config, pkgs, ... }: {
  # TIP: use this to prioritize networks imperatively
  # nmcli connection modify SSID connection.autoconnect-priority 10
  # TODO: actually learn how networkmanager and especially nmcli work (lol)
  # (although I really struggle with that due to graphical auth, etc.)

  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    plugins = [ pkgs.networkmanager-openconnect ];
  };

  users.users.${config.my.username}.extraGroups = [ "networkmanager" ];
}
