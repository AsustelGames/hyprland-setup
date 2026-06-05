{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = false;
    branch = "legacy_580";

  };
}

