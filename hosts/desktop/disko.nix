{
  disko.devices = {
    disk = {

      system = {
        device = "/dev/nvme0n1";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            ESP = {
              label = "boot";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            nixos = {
              label = "nixos";
              size = "64G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };

            home = {
              label = "home";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };

          }; #
        };
      };

    }; #
  };
}
