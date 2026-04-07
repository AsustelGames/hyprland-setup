{ pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    ly
    hyprland
    steam

    linuxPackages.cpupower
    lact

    qemu
    virt-manager
    virt-viewer
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.lact.enable = true;
}
