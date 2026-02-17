{
  description = "A Vradical New Configuration Conflagaration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: let
    nixpkgsSettings = { config.allowUnfree = true; };
  in {
    nixosConfigurations.tranticicero = nixpkgs.lib.nixosSystem { modules = [
      { nixpkgs.hostPlatform = "x86_64-linux"; }
      nixpkgsSettings
      ./hosts/tranticicero
    };
  };
}
