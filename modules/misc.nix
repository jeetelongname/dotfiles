{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    castor # TODO: fix castor
    firefox
  ];

  xdg.configFile = {
    "castor/settings.toml".source = ../config/misc/castor.toml;
    "libinput-gestures.conf".source = ../config/misc/libinput-gestures.conf;
    "user-dirs.dirs".source = ../config/misc/user-dirs.dirs;
    "user-dirs.locale".source = ../config/misc/user-dirs.locale;

  };
}
