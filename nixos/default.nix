let
  subDir = ./default;
in {
  imports = [
    (subDir + "/audio.nix")
    (subDir + "/misc.nix")
    (subDir + "/greeter.nix")
    (subDir + "/users.nix")
    (subDir + "/wm.nix")
    (subDir + "/wireless.nix")
    (subDir + "/virtual-machine.nix")
  ];
}
