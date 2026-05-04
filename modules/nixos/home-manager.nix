{ config, inputs, secret-settings, ... }: {
  # including home config as a module, passing down necessary system config
  home-manager.users.${config.my.username} = { lib, ... }: {
    imports = [
      ../../modules/home
      (secret-settings.homeModule or {})
    ];
    home.username = lib.mkForce config.my.username;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs secret-settings; };
  };
}
