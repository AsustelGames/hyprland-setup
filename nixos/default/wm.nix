{
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  services.displayManager.sessionData.autologinSession = null;

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
}
