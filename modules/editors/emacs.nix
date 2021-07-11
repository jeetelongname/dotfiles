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

  emacspgtkgcc = (pkgs.emacsPackagesGen unstable.emacsPgtkGcc).emacsWithPackages
    (epkgs: [ epkgs.vterm ]);

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
  ];

  programs.emacs = {
    enable = true;
    package = emacspgtkgcc; # accidentally compiling emacs:
  };

  xdg.configFile = {
    "chemacs/profiles.el".source =
      config.lib.file.mkOutOfStoreSymlink ../../config/emacs/profiles.el;
    # "doom".source = ../config/emacs/doom;
  };
}
