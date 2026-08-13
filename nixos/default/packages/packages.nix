{ pkgs, lib, inputs, config, enableAllPkgs, ... }:

let
  requiredPkgs = with pkgs; [
    ### Main ###
    ly
    hyprland
    xinit
    i3
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
    #bottles
    #wine
    prismlauncher
    kitty
    lact
    mission-center
    #aseprite
    #kicad-unstable-small
    #nwg-look
    mangohud
    goverlay

    ### Tui programs ###
    bluetui
    wiremix
    btop
    yazi
    mpv
    lazygit
    zsh
    fzf

    ### Cli ###
    glmark2
    cava
    clang-tools
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
    p7zip
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
    python3

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
  }; 
}
