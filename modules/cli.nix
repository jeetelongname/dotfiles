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

  programs.fzf = {
    # TODO config fzf
    enable = true;
  };
}
