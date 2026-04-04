{ config, inputs, secrets, ... }: {
  # TODO: options.my.home-manager.enable

  # including home config as a module, passing down necessary system config
  home-manager.users.${config.my.username} = { lib, ... }: {
    imports = [ ../../modules/home ];
    my.username = lib.mkForce config.my.username;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs secrets; };
  };
};
