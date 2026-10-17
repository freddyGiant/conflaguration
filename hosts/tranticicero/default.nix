# TODO: make this pattern into an option
{ pkgs, inputs, ... }: {
  flake.modules.nixos.tranticicero = { ... }: {
    imports = [
      ./hardware-configuration.nix
    ]
    ++ (with inputs.self.modules.nixos; [
      niri
    ]);
  };

  flake.modules.homeManager.tranticicero.imports = with inputs.self.modules.homeManager; [
    gaming
    niri
  ];

  flake.nixosConfigurations.tranticicero = pkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      { networking.hostName = "tranticicero"; }
      inputs.self.modules.nixos.tranticicero

      inputs.home-manager.nixosModules.home-manager
      { home-manager.sharedModules = [ inputs.self.modules.homeManager.tranticicero ]; }
    ];
  };
}
