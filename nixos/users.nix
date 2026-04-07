{ pkgs, lib, inputs, ... }:

{
  users.users.asustel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "kvm" ];
    packages = with pkgs; [
      tree
    ];
  };
}
