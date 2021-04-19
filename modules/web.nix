{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    caddy
    firefox
    nodePackages.sass
    yarn

  ];
}
