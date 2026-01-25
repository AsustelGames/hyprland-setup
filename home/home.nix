{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./modules/default.nix
  ];
  
  home.username = "asustel";
  home.homeDirectory = "/home/asustel";
  

  home.file = {
    "Documents/._".text = "";
    "Downloads/._".text = "";
    "Photos/Screenshots/._".text = "";
    "Projects/._".text = "";
    "Videos/OBS/._".text = "";

    #".bashrc".source = dotfiles/bashrc/bashrc;
    ".config/yazi".source = dotfiles/yazi;
    #".config/obs-studio".source = dotfiles/obs;
    #".config/micro".source = dotfiles/micro;
    #".config/Code".source = dotfiles/vscode;
  };

  xdg.configFile = {
    "kitty".source = dotfiles/kitty;
    "fastfetch".source = dotfiles/fastfetch;
    "hypr".source = dotfiles/hyprland;
    "rofi".source = dotfiles/rofi;
    "waybar".source = dotfiles/waybar;
  };

  home.stateVersion = "25.11";
}
