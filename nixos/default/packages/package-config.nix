{ pkgs, lib, config, ... }:

{
  config = lib.mkIf config.enableAllPkgs {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    programs.gamemode.enable = true;

    services.udisks2.enable = true;
    services.power-profiles-daemon.enable = true;
    services.lact.enable = true;
    services.tailscale.enable = true;

    # xdg.portal = {
    #   enable = true;
    #
    #   extraPortals = [
    #     pkgs.xdg-desktop-portal-termfilechooser
    #   ];
    #
    #
    #   config = {
    #     hyprland = {
    #       "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    #     };
    #   };
    # };

  };
}
