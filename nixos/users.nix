{ pkgs, lib, inputs, ... }:

{
  users.users.asustel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };  
}
