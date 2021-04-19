{ config, lib, pkgs, ... }:

# for all the cli programs I use
{
  home.packages = with pkgs; [ # all the cli apps I use
    bat
    bitwarden-cli
    dragon-drop
    fd
    htop
    jq
    lf
    neofetch
    pandoc
    pass
    pfetch
    pulsemixer
    qrencode
    ripgrep
    stow
    topgrade
    tree
    xdo
    xdotool

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
