{
  description = "I use NixOS btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    npu-hyprland.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    npu-kitty.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    npu-yazi.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    npu-rofi.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    npu-waybar.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, zen-browser, ... } @ inputs:
  let
    system = "x86_64-linux";
    
    # commonHomeManagerConfig = {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    #   home-manager.backupFileExtension = "bak";
    #   home-manager.users.asustel = import ./home/home.nix;
    # };

    mkHost = {
      name,
      enableAllPkgs ? true,
    }:
      nixpkgs-unstable.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
        inherit enableAllPkgs;
      };

      modules = [
        ./hosts/${name}/configuration.nix
        # home-manager.nixosModules.home-manager
        # commonHomeManagerConfig
      ];

    };
  in {
    nixosConfigurations = {
      ### desktop
      desktop = mkHost {
        name = "desktop";
      };
      fi-desktop = mkHost {
        name = "desktop";
        # Enable only the required packages
        # For faster installation
        enableAllPkgs = false;
      };

      ### tablet
      tablet = mkHost {
        name = "tablet";
      };
      fi-tablet = mkHost {
        name = "tablet";
        # Enable only the required packages
        # For faster installation
        enableAllPkgs = false;
      };

    }; #
  };
}
