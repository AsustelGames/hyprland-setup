{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # Desktop
    nerd-fonts.martian-mono
    rofi
    waybar
    hyprshot
    hyprpaper
    hyprpicker
    hypridle
    
    # Programs
    vscode
    nwg-look
    brave
    obs-studio
    audacity
    ferdium
    # steam # in configuration.nix or else won't work
    bottles
    prismlauncher
    discord
    kitty
    
    # Cli Programs
    neovim
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
    tty-clock
    gcc
    
    # misc
    alsa-lib
  ];

  programs.home-manager.enable = true;
}
