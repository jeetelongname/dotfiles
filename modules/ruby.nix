{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ruby_2_7 # does not bundle openssl.. which means I can't use gem or bundle or anything
    ruby
    rake
    rubocop
    rufo
    solargraph

  ];
}
