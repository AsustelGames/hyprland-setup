{ pkgs, ... }:

{
  catppuccin = {
    flavor = "macchiato";
    brave.enable = true;
    btop.enable = true;
  };


  gtk = {
    enable = true;
    
    theme = {
      name = "Catppuccin-Macchiato-Standard";
      package = pkgs.catppuccin;
    };
    
    
    #catppuccin.flavor = "macchiato";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata -Cursors";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
