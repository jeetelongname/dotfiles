{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    caddy
    firefox
    nodePackages.sass
    nodePackages.yarn

  ];
}
