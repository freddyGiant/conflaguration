{
  home-manager.users.vrad = { ... }: {
    imports = [ ../../modules/home ];
    home.username = "vrad";
    home.homeDirectory = "/home/vrad";
    home.stateVersion = "25.05";
  };
};
