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
  

  home.stateVersion = "25.11";
}
