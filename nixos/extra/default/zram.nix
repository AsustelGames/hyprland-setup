{
  systemd.oomd.enable = true;

    zramSwap = {
      enable = true;
      memoryPercent = 50;
      algorithm = "lz4";
      priority = 100;
    };

}
