{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # Desktop
    nerd-fonts.martian-mono
    catppuccin
    rofi
    waybar
    hyprshot
    hyprpaper
    hyprpicker
    
    # Programs
    vscode
    brave
    obs-studio
    audacity
    discord
    # steam # in configuration.nix or else won't work
    bottles
    prismlauncher
    kitty
    
    # Cli Programs
    micro
    bluetui
    wiremix
    btop
    yazi
    mpv
    lazygit
    
    # Cli Utilities
    cmake
    ninja
    fastfetch
    cmatrix
    tldr
    man
    p7zip # It took me 30 mins to find out why it was throwing the error at line 27, 7zip -> p7zip 
    dysk
    cloc
    git
    cliphist
    wl-clipboard
    bat
    udiskie
    gcc
  ];

  programs.home-manager.enable = true;
}
