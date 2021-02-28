{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ isync msmtp ];
}
