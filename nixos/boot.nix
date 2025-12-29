{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 2d";
}
