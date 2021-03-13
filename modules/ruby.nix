{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ruby_2_7
    rake
    rubocop
    rufo
    solargraph

  ];
}
