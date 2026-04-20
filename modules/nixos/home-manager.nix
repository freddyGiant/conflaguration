{ config, inputs, secret-settings, ... }: {
  # TODO: options.my.home-manager.enable

  # including home config as a module, passing down necessary system config
  home-manager.users.${config.my.username} = { lib, ... }: {
    imports = [ ../../modules/home ];
    home.username = lib.mkForce config.my.username;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs secret-settings; };
  };
};
