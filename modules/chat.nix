{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    element-desktop

  ];
}
