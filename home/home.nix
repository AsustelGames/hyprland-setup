{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];
  
  home.username = "asustel";
  home.homeDirectory = "/home/asustel";
  

  home.stateVersion = "25.11";
}
