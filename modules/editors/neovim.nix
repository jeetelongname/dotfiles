{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  home.packages = with pkgs; [
    neovim
    python312Packages.pynvim # pip install --user --upgrade pynvim

  ];

  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink ../../config/neovim;
  };
}
