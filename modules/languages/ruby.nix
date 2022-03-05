{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pry # repl
    rake # ruby make
    rubocop # linter
    # ruby # the language, for some reason its breaking so I insalled from system :(
    rufo # formatter
    solargraph # ls

  ];
}
