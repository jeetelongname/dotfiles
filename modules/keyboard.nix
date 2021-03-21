{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      interception-tools

    ];
}

# due to limitations in the services I can use I have had to compile this (and caps2esc)
# from source which is less than ideal
# this gude helped me https://askubuntu.com/questions/979359/how-do-i-install-caps2esc You also need to install
# libboost-dev
