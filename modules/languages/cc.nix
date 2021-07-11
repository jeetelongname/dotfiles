{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-manpages
    clang-tools
    # clang_12
    cmake

  ];
}
