{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    python38Packages.ipython
    python38Packages.python-language-server

  ];
}
