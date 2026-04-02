{
  home-manager = {
    users.${config.my.username} = { ... }: {
      imports = [ ../../modules/home ];
      # home.username = "vrad";
      # home.homeDirectory = "/home/vrad";
      # home.stateVersion = "25.05";
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
};
