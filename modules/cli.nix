{ config, lib, pkgs, ... }:

# for all the cli programs I use
{
  home.packages = with pkgs; [
    # all the cli apps I use
    bat
    bitwarden-cli
    calc
    xdragon
    exa
    fd
    htop
    jq
    heroku
    lf
    neofetch
    nmap
    pandoc
    pass
    pfetch
    pulsemixer
    qrencode
    ripgrep
    stow
    topgrade
    tree
    tty-clock
    xdo
    xdotool

  ];

  xdg.configFile = {
    "topgrade.toml".source =
      config.lib.file.mkOutOfStoreSymlink ../config/cli/topgrade.toml;
    "neofetch/config.conf".source =
      config.lib.file.mkOutOfStoreSymlink ../config/cli/neofetch.conf;
    "htop/htoprc".source =
      config.lib.file.mkOutOfStoreSymlink ../config/cli/htoprc;
    "pulsemixer.cfg".source =
      config.lib.file.mkOutOfStoreSymlink ../config/cli/pulsemixer.cfg;

  };

  programs.fzf = {
    # TODO config fzf
    enable = true;
  };
}
