{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-manpages
    clang-tools
    cmake

  ];
}
