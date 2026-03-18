{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];
  
  home.username = "asustel";
  home.homeDirectory = "/home/asustel";
  

  home.file = {
    "Documents/._".text = "";
    "Downloads/._".text = "";
    "Photos/Screenshots/._".text = "";
    "Projects/._".text = "";
    "Videos/OBS/._".text = "";
  };
  

  home.stateVersion = "25.11";
}
