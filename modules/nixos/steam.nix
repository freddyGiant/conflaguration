{
  programs.steam = {
    # see https://nixos.wiki/wiki/Steam
    enable = true;

    # may or may not be necessary
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.xone.enable = true;
}
