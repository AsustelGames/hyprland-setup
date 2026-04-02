{ pkgs, lib, inputs, ... }:

{
  users.users.asustel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "i2c" ];
    packages = with pkgs; [
      tree
    ];
  };
}
