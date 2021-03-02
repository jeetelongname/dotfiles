{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  # gtk = {
  #   enable = true;
  #   font = {
  #     package = pkgs.noto-fonts;
  #     name = "Noto Sans 10 ";
  #   };
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus-Dark";
  #   };
  #   theme = {
  #     package = pkgs.pop-gtk-theme;
  #     name = "Pop-Dark";
  #   };

  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = 0;
  #     gtk-cursor-theme-name = "Adwaita";
  #     gtk-cursor-theme-size = 0;
  #     gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
  #     gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR"; #     gtk-button-images = 1;
  #     gtk-menu-images = 0;
  #     gtk-enable-event-sounds = 1;
  #     gtk-enable-input-feedback-sounds = 1;
  #     gtk-xft-antialias = 1;
  #     gtk-xft-hinting = 1;
  #     gtk-xft-hintstyle = "hintfull";

  #   };
  # };

  home = {
    username = "jeet";
    homeDirectory = "/home/jeet";

    # TODO move this out of here
    packages = with pkgs; [
      caddy
      nixfmt
      shfmt
      gimp

    ];

    stateVersion = "21.05";
  };

  imports = [
    modules/cli.nix
    modules/chat.nix
    modules/emacs.nix
    modules/fun.nix
    modules/git.nix
    modules/email.nix
    modules/misc.nix
    # modules/nix.nix
    modules/neovim.nix
    modules/terminal.nix
    modules/shell.nix

  ];

}
