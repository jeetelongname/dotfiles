{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ alacritty ];

  xdg.configFile."alacritty/alacritty.yml".source =
    ../config/terminal/alacritty.yml;

  # TODO: move more of the config into home manager
  programs.tmux = {
    enable = true;
    # config
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = false;
    historyLimit = 30000;
    keyMode = "vi";

    extraConfig = "source-file ~/.config/nixpkgs/config/terminal/tmux.conf";
  };
}
