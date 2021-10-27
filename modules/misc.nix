{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    castor # TODO: fix castor
    firefox
    screenkey
    audacity
    gimp
    zathura
    uwuify
    filezilla
    xournalpp
    calibre

    lua
    lua52Packages.luarocks
    fennel
  ];

  xdg.configFile = {
    "castor/settings.toml".source =
      config.lib.file.mkOutOfStoreSymlink ../config/misc/castor.toml;
    "libinput-gestures.conf".source =
      config.lib.file.mkOutOfStoreSymlink ../config/misc/libinput-gestures.conf;
    "user-dirs.dirs".source =
      config.lib.file.mkOutOfStoreSymlink ../config/misc/user-dirs.dirs;
    "user-dirs.locale".source =
      config.lib.file.mkOutOfStoreSymlink ../config/misc/user-dirs.locale;
    # "systemd/user/homepage.service".source =
    #   config.lib.file.mkOutOfStoreSymlink ../config/misc/homepage.service;
  };
}
