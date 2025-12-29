{ pkgs, ... }:

{
  gtk = {
    enable = true;
    
    theme = {
      name = "Omni";
      package = pkgs.omni-gtk-theme;
    };
    
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
