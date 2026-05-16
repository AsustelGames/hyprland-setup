{ pkgs, ... }:

{  
  home.packages = with pkgs; [
    # == Core ==
    rofi
    waybar
    ags
    eww
    hyprshot
    awww
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    swaynotificationcenter
    libnotify
    ydotool

    # == Virtual Machine
    #qemu
    #kvmtool
    #virt-manager
    #virtiofsd
    
    # == Looks ==
    nerd-fonts.martian-mono
    bibata-cursors
    graphite-gtk-theme
    
    # == Programs ==
    vscode
    brave
    obs-studio
    audacity
    discord
    # steam # in configuration.nix or else won't work
    #bottles
    wine
    prismlauncher
    kitty
    aseprite
    kicad-unstable-small
    nwg-look
    mangohud
    goverlay
    glmark2
    
    # == Cli Programs ==
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
    clang-tools
    
    # == Cli Utilities ==
    jq
    psmisc
    fastfetch
    cmatrix
    tldr
    man
    p7zip
    dysk
    cloc
    git
    cliphist
    wl-clipboard
    brightnessctl
    stow
    udiskie
    eza
    stress-ng
    lm_sensors
    gomplate
    python3
    
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
