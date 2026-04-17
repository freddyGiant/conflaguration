{
  localsend = {
    enable = true;
    openFirewall = true;
    # equivalent to
    # environment.systemPackages = [ cfg.package ];
    # networking.firewall.allowedTCPPorts = lib.optionals cfg.openFirewall [ firewallPort ];
    # networking.firewall.allowedUDPPorts = lib.optionals cfg.openFirewall [ firewallPort ];
    # where filewallPort = 53317
  };
}
