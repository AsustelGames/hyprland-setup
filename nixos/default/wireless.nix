{
  networking = {
    hostName = "asustel-nixos";
    networkmanager.enable = true;
  };
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
