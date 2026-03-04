{
  description = "I use NixOS btw, and have no idea what i'm doing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  	
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    
    commonHomeManagerConfig = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bak";
      home-manager.users.asustel = import ./home/home.nix;
    };
  in {
  	nixosConfigurations = {
  	   # Laptop Config
       laptop = nixpkgs-unstable.lib.nixosSystem {
         specialArgs = { inherit inputs; };
         system = system;
         
         modules = [
          ./hosts/laptop/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          commonHomeManagerConfig
          inputs.dms.nixosModules.dank-material-shell
         ];
       };

       # Desktop Config
       desktop = nixpkgs-unstable.lib.nixosSystem {
         specialArgs = { inherit inputs; };
         system = system;
         
         modules = [
          ./hosts/desktop/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          commonHomeManagerConfig
         ];    
       };
          
    };
  };
}
