{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pry # repl
    rake # ruby make
    rubocop # linter
    ruby # the language
    rufo # formatter
    solargraph # ls

  ];
}
