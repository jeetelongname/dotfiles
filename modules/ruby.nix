{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    rake
    rubocop
    ruby
    rufo
    solargraph

  ];
}
