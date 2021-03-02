{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    languagetool
    sqlite

  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc; # accidentally compiling emacs:
    extraPackages = epkgs: [ epkgs.emacs-libvterm ];
  };

  xdg.configFile = {
    "chemacs/profiles.el".source = ../config/emacs/profiles.el;
    # "doom".source = ../config/emacs/doom;
  };
}
