{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ texlive.combined.scheme-full ];
}
