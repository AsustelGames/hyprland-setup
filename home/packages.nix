{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # Desktop
    nerd-fonts.martian-mono
    # ly # in configuration.nix
    # hyprland # in configuration.nix
    rofi
    waybar
    hyprshot
    hyprpaper
    hyprpicker
    hypridle
    
    # Programs
    nwg-look
    firefox
    brave
    obs-studio
    audacity
    ferdium
    # steam # in configuration.nix else won't work
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
    fzf
    man
    p7zip # It took me 30 mins to find out why it was throwing the error at line 27, 7zip -> p7zip 
    dysk
    cloc
    git
    cliphist
    wl-clipboard
    bat
    udiskie
    tmux
    tty-clock
  ];

  programs.home-manager.enable = true;
}
