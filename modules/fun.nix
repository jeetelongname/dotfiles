{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cmatrix
    cowsay
    figlet
    lolcat
    moon-buggy
    sl

  ];
}
