{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # == Desktop ==
    nerd-fonts.martian-mono
    rofi
    waybar
    hyprshot
    hyprpaper
    hyprpicker
    swaynotificationcenter
    
    # == Programs ==
    vscode
    brave
    obs-studio
    audacity
    discord
    # steam # in configuration.nix or else won't work
    bottles
    prismlauncher
    kitty
    aseprite
    kicad-unstable-small
    nwg-look
    
    # == Cli Programs ==
    micro
    nvim
    bluetui
    wiremix
    btop
    yazi
    mpv
    lazygit
    zsh
    oh-my-zsh
    eza
    starship
    
    # == Cli Utilities ==
    jq
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
    brightnessctl
    stow
    udiskie
    
    # == In shell.nix ==
    # cmake
    # ninja
    # meson
    # gnumake
    gcc
    # pkg-config
    # sdl3
  ];

  programs.home-manager.enable = true;
}
