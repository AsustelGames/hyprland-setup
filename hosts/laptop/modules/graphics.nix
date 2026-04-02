{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia"]; #"intel" 

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = false;
    #prime = {
    #  offload = {
    #    enable = true;
    #    enableOffloadCmd = true;
    #  };

    #  intelBusId = "PCI:0:2:0";
    #  nvidiaBusId = "PCI:1:0:0";
    #};
  };
}

