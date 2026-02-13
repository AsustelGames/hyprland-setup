{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    cmake
    ninja
    meson
    gnumake
    gcc
    pkg-config
    sdl3
  ];

  shellHook = ''
    echo "Ready to Develop"
  '';
}
