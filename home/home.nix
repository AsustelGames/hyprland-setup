{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./modules/default.nix
  ];
  
  home.username = "asustel";
  home.homeDirectory = "/home/asustel";

  home.sessionVariables = {
    EDITOR = "nvim";
    
  };



  programs.home-manager.enable = true;


  home.stateVersion = "25.11";
}
