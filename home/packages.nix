{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # == Core ==
    rofi
    waybar
    hyprshot
    hyprpaper
    hyprpicker
    swaynotificationcenter
    
    # == Looks ==
    nerd-fonts.martian-mono
    nerd-fonts.profont 
    bibata-cursors
    graphite-gtk-theme
    
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
    neovim
    bluetui
    wiremix
    btop
    yazi
    mpv
    lazygit
    zsh
    oh-my-zsh
	 cava
    
    # == Cli Utilities ==
    jq
	 psmisc
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
    eza
    
    # == In shell.nix ==
    # cmake
    # ninja
    # meson
    # gnumake
    gcc
    # pkg-config
    # sdl3

    # == Compatibility Fonts
    corefonts
    vista-fonts
    noto-fonts
  ];

  programs.home-manager.enable = true;
}
