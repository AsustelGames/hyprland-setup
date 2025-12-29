{ pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    ly
    hyprland
    steam
  ];
  
  programs.steam.enable = true;
  services.udisks2.enable = true;
}
