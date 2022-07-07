{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    foot
    # abduco
    # dvtm-unstable
    # termite

  ];

  xdg.configFile = {
    "alacritty/alacritty.yml".source =
      config.lib.file.mkOutOfStoreSymlink ../config/terminal/alacritty.yml;
    "foot/foot.ini".source =
      config.lib.file.mkOutOfStoreSymlink ../config/terminal/foot.ini;
  };

  # TODO: move /less/ of my tmux config into home manager
  programs.tmux = {
    enable = true;
    # config
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = false;
    historyLimit = 30000;
    keyMode = "vi";
    secureSocket = true;

    plugins = with pkgs; [
      { plugin = tmuxPlugins.yank; }
      { plugin = tmuxPlugins.battery; }
      { plugin = tmuxPlugins.open; }
      { plugin = tmuxPlugins.prefix-highlight; }
    ];
    extraConfig = "source-file ~/.dotfiles/config/terminal/tmux.conf";
  };
}
