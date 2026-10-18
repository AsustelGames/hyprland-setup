{ pkgs, lib, inputs, config, enableAllPkgs, ... }:

let
  requiredPkgs = with pkgs; [
    ### Main ###
    ly
    inputs.hyprland.packages.${pkgs.system}.default
    udiskie

    ### Cli ###
    neovim
    git

    ### Programs ###
    kitty
    brave
  ];
  otherPkgs = with pkgs; [
    ### Main ###
    hyprshutdown
    rofi
    waybar
    quickshell
    #ags
    #eww
    hyprshot
    awww
    hyprpicker
    hyprlock
    hypridle
    swaynotificationcenter
    libnotify

    ### Looks ###
    bibata-cursors
    #graphite-gtk-theme

    ### Programs ###
    #vscodium
    brave
    steam
    obs-studio
    audacity
    discord
    drawy
    #bottles
    #wine
    prismlauncher
    kitty
    lact
    mission-center
    shotcut
    #aseprite
    #kicad-unstable-small
    #nwg-look
    mangohud
    goverlay

    ### Tui programs ###
    bluetui
    wiremix
    inputs.yazi.packages.${pkgs.system}.default
    xdg-desktop-portal-termfilechooser
    xdg-desktop-portal
    mpv
    lazygit
    zsh
    fzf

    ### Cli ###
    glmark2
    cava
    clang-tools
    qt6.qtdeclarative
    yt-dlp
    ffmpeg
    perf
    ripgrep
    jq
    shellcheck
    psmisc
    fastfetch
    cmatrix
    pipes-rs
    tldr
    man
    p7zip # Used in Yazi
    dysk
    cloc
    cliphist
    wl-clipboard
    brightnessctl
    stow
    udiskie
    eza
    stress-ng
    lm_sensors
    gomplate
    python313
    manim
    tree-sitter # Used in Nvim

    ### C++ coding tools (Also included in shell.nix) ###
    cmake
    ninja
    meson
    gnumake
    gcc
    pkg-config
    sdl3
  ];
  fontPkgs = with pkgs; [
    ### looks ###
    nerd-fonts.martian-mono
    nerd-fonts.departure-mono
    nerd-fonts.hurmit
    nerd-fonts.profont

    ### Compatibility fonts ###
    corefonts
    vista-fonts
    noto-fonts
  ];
in

{
  # Config for otherPkgs
  imports = [
    ./package-config.nix
  ];

  options.enableAllPkgs = lib.mkEnableOption "All packages";

  config = {
    enableAllPkgs = enableAllPkgs;

    nixpkgs.config.allowUnfree = true;

    fonts.packages =
      lib.optionals config.enableAllPkgs fontPkgs;
  
    environment.systemPackages =
      requiredPkgs
      ++ lib.optionals config.enableAllPkgs otherPkgs;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Config for requiredPkgs
    services.udisks2.enable = true; 
    
    # environment.etc."xdg/scripts/yazi-open" = {
    #   mode = "0755";
    #   text = ''
    #     #!/bin/sh
    #
    #     if [ -d "$1" ]; then
    #       exec yazi "$1"
    #     else
    #       exec yazi --select "$1"
    #         fi
    #         '';
    # };
    #
    # xdg.desktopEntries.yazi = {
    #   name = "Yazi";
    #   genericName = "File Manager";
    #   exec = "/etc/xdg/scripts/yazi-open %f";
    #   terminal = true;
    #   type = "Application";
    #   mimeType = [
    #     "inode/directory"
    #   ];
    # };
  };
}
