{ config, lib, pkgs, ... }:

let
  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url =
            "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        }))
      ];
    };

in {

  home.packages = with pkgs; [
    # package dev
    cask

    # checkers/spell
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))

    # checkers/grammer
    languagetool

    # tools/format
    nixfmt
    shfmt

    # tools/editorconfig
    editorconfig-core-c

    # lang/sh
    shellcheck

    # so many
    sqlite
    xclip

    # # pdf tools
    # automake
    # autoconf
    # pkg-config
    # libpng
    # zlib
    # poppler
    sdcv
  ];

  programs.emacs = {
    enable = true;
    package = unstable.emacs-unstable;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  xdg.configFile = {
    "chemacs/profiles.el".source =
      config.lib.file.mkOutOfStoreSymlink ../../config/emacs/profiles.el;
    "doom".source = config.lib.file.mkOutOfStoreSymlink ../../config/doom;
  };
}
