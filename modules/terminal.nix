{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    foot
    tmux
    # abduco
    # dvtm-unstable
    urlview

  ];

  xdg.configFile = {
    "alacritty/alacritty.yml".source =
      config.lib.file.mkOutOfStoreSymlink ../config/terminal/alacritty.yml;
    "foot/foot.ini".source =
      config.lib.file.mkOutOfStoreSymlink ../config/terminal/foot.ini;
    "tmux/tmux.conf".source =
      config.lib.file.mkOutOfStoreSymlink ../config/terminal/tmux.conf;
  };

  # TODO: move /less/ of my tmux config into home manager
}
