{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };
}

