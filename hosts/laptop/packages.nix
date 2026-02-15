{ pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    ly
    hyprland
    awesome
    steam
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  services.udisks2.enable = true;
}
