{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ emacs ];

  xdg.configFile = {
    "chemacs/profiles.el".source = ../config/emacs/profiles.el;
    "doom".source = ../config/emacs/doom;
  };
}
