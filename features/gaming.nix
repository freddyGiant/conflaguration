{
  conflaguration.modules.gaming.nixos = {
    programs.steam.enable = true;
    programs.steam = {
      # may or may not be necessary
      # see https://nixos.wiki/wiki/Steam
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    hardware.xone.enable = true;
  };
}
