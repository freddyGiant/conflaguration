{ config, conflagurationPath, inputs, ... }: {
  # including home config as a module, passing down necessary system config
  home-manager.users.${config.my.username} = { lib, ... }: {
    imports = [
      ../../modules/home
      (inputs.secret-settings.homeModule or {})
    ];
    home.username = lib.mkForce config.my.username;
  };

  home-manager.extraSpecialArgs = { inherit conflagurationPath inputs; };
  home-manager.backupFileExtension = "~";
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
