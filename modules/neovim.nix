{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  home.packages = with pkgs; [ neovim-nightly ];

  # TODO: redo neovim config
  # xdg.configFile = {
  #   "nvim/".source = ../config/neovim;
  # };
}
