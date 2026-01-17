{ pkgs, lib, ... }:

{
#  programs.btop.enable = true;
#  programs.brave.enable = true;
#  programs.lazygit.enable = true;
#  programs.micro.enable = true;
#  programs.vscode.enable = true;
#  programs.bat.enable = true;

#  catppuccin = {
#    enable = true;
#    flavor = "macchiato";
#  };




  gtk = {
    enable = true;
    colorScheme = "dark";
    


    theme = {
      name = "tokyonight";
      package = pkgs.tokyonight-gtk-theme;
    };
    
    #gtk3.extraConfig = {
    #  gtk-application-prefer-dark-theme = true;
    #};

    #gtk4.extraConfig = {
    #  gtk-application-prefer-dark-theme = true;
    #};

    #iconTheme = {
    #  name = "Beauty-Line";
    #  package = pkgs.beauty-line-icon-theme;
    #};

    cursorTheme = {
      name = "Bibata Cursors";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };
}
