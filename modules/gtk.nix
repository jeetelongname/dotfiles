{ config, lib, pkgs, ... }:

# https://joshtronic.com/2017/07/26/hide-title-bars-in-gnome-shell/ to disable titlebars
{
  gtk = {
    enable = true;
    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans 10 ";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.pop-gtk-theme;
      name = "Pop-Dark";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
      gtk-cursor-theme-name = "Adwaita";
      gtk-cursor-theme-size = 0;
      gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
      gtk-toolbar-icon-size =
        "GTK_ICON_SIZE_LARGE_TOOLBAR"; # gtk-button-images = 1;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintfull";

    };
  };
}
