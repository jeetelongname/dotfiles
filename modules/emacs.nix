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
    # checkers/grammer
    languagetool

    # tools/format
    nixfmt
    shfmt

    # so many
    sqlite
  ];

  programs.emacs = {
    enable = true;
    package = emacspgtkgcc; # accidentally compiling emacs:
  };

  xdg.configFile = {
    "chemacs/profiles.el".source = ../config/emacs/profiles.el;
    # "doom".source = ../config/emacs/doom;
  };
}
