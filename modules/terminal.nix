{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      alacritty
      # termite

    ];

  xdg.configFile = {
    "alacritty/alacritty.yml".source = ../config/terminal/alacritty.yml;
    # "termite/config".source = ../config/terminal/termite.conf;
  };

  # TODO: move more of my tmux config into home manager
  programs.tmux = {
    enable = true;
    # config
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = false;
    historyLimit = 30000;
    keyMode = "vi";
    secureSocket = true;

    extraConfig = "source-file ~/.dotfiles/config/terminal/tmux.conf";
  };
}
