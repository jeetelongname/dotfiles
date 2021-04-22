{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry # dep manager
    python38Packages.ipython # repl
    python38Packages.python-language-server # ls

  ];
}
