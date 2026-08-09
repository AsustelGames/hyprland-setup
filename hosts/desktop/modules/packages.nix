{ pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    ly
    hyprland
    i3
    xinit
    steam
    rpi-imager

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    linuxPackages.cpupower
    lact

    qemu
    virt-manager
    virt-viewer
    tailscale
    virtiofsd
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.lact.enable = true;
  services.tailscale.enable = true; 
}
