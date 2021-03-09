{ config, lib, pkgs, ... }:

# for all the cli programs I use
{
  home.packages = with pkgs; [
    # all the cli apps I use
    ripgrep
    bat
    fd
    neofetch
    pfetch
    lf
    jq
    htop
    topgrade
    xdo
    xdotool
    pandoc
    pass
    pulsemixer
    tree

  ];

  xdg.configFile = {
    "topgrade.toml".source = ../config/cli/topgrade.toml;
    "neofetch/config.conf".source = ../config/cli/neofetch.conf;
    "htop/htoprc".source = ../config/cli/htoprc;
    "pulsemixer.cfg".source = ../config/cli/pulsemixer.cfg;

  };

  programs.fzf = {
    # TODO config fzf
    enable = true;
  };
}
