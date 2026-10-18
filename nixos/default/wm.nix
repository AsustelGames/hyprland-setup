{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.displayManager.sessionData.autologinSession = null;
}
