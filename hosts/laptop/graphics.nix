{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" "modesetting" ]; # amdgpu for amd
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
