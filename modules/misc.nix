{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      castor # TODO: fix castor

    ];

  xdg.configFile = {
    "castor/settings.toml".source = ../config/misc/castor.toml;

  };
}
