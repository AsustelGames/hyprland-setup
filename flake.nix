{
  description = "I use NixOS btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, zen-browser, ... } @ inputs:
  let
    system = "x86_64-linux";
    
    commonHomeManagerConfig = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bak";
      home-manager.users.asustel = import ./home/home.nix;
    };

    mkHost = {
      name,
      enableAllPkgs ? true,
    }:
      nixpkgs-unstable.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./hosts/${name}/configuration.nix
        home-manager.nixosModules.home-manager
        commonHomeManagerConfig
      ];

      {
        inherit enableAllPkgs;
      }
    };
  in {
    nixosConfigurations = {
      desktop = mkHost {
        name = "desktop";
      };


    };
  };
}
