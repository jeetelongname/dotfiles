{ config, lib, pkgs, ... }:

# for all the cli programs I use
{
  home.packages = with pkgs; [
    # all the cli apps I use
    ripgrep
    bat
    fd
    neofetch
    lf
    jq
    htop
    topgrade
    xdo
    xdotool
    pandoc
    pass
    tree

  ];

  xdg.configFile = {
    "topgrade.toml".source = ../config/cli/topgrade.toml;
    "neofetch/config.conf".source = ../config/cli/neofetch.conf;
  };

  programs.fzf = {
    # TODO config fzf
    enable = true;
  };
}
