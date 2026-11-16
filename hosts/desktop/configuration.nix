{ config, lib, pkgs, ... }:


let
  myVars = {
    configDataDir = "/nixos-config-data";
    currentHost = "desktop";
  };
in

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/default.nix
    ./modules/default.nix
    ];

  # _module.args.myVars = {
  #   configDataDir = "/nixos-config-data";
  #   currentHost = "desktop";
  # };

  system.activationScripts.nixos-config-data = {
    deps = [ "users" ];

    text = ''
      rm -r ${myVars.configDataDir}
      mkdir -p ${myVars.configDataDir}


      mkdir -p ${myVars.configDataDir}/host
      echo "${myVars.currentHost}" > ${myVars.configDataDir}/host/current

      mkdir -p ${myVars.configDataDir}/pkgs
      echo "${if config.enableAllPkgs then "true" else "false"}" > ${myVars.configDataDir}/pkgs/allEnabled

      echo "This directory is used to store information
      about how nixos configured that can be easily accessed
      by scripts that need it e.g what is the current system host.
      To ensure everything that could use it works properly
      don't delete this directory" > ${myVars.configDataDir}/what-is-this.txt
      '';
  };
  
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Zurich";

  
  system.stateVersion = "25.11"; # DO NOT CHANGE!
}
