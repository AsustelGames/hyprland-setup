{
  # input
  services.libinput.enable = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
