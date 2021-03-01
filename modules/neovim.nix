{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ neovim ];

  # TODO: redo neovim config
  xdg.configFile = {
    "nvim/".source = ../config/neovim;

  };
}
