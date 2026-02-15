{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../nixos/default.nix
      ./hardware-configuration.nix
      ./packages.nix
      ./graphics.nix
    ];
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Zurich";

  
  system.stateVersion = "25.11"; # DO NOT CHANGE!
}
