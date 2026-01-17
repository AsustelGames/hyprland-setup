{
  description = "I use NixOS btw, and have no idea what i'm doing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... } @ inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
       laptop = nixpkgs.lib.nixosSystem {
         specialArgs = { inherit inputs; };
         system = system;
         
         modules = [
          ./hosts/laptop/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.sharedModules = [
            #  catppuccin.homeModules.catppuccin
            #];
            home-manager.backupFileExtension = "bak";
            home-manager.users.asustel = import ./home/home.nix;
          }
          #catppuccin.nixosModules.catppuccin
         ];
       };
       
       desktop = nixpkgs.lib.nixosSystem {
         specialArgs = { inherit inputs; };
         
         system = system;
         modules = [
          ./hosts/desktop/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.sharedModules = [
            #  catppuccin.homeModules.catppuccin
            #];
            home-manager.backupFileExtension = "bak";
            home-manager.users.asustel = import ./home/home.nix;
          }
          #catppuccin.nixosModules.catppuccin
         ];    
       };
          
    };
  };
}
