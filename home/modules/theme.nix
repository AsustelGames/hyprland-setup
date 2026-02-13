{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";
    
    cursorTheme = {
      name = "Bibata Cursors";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
