{ pkgs, osConfig, ... }: {
  home.packages = [ pkgs.quickshell.${osConfig.nixpkgs.hostPlatform}.default ];
}
