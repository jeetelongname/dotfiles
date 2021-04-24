{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
    cabal-install
    haskellPackages.brittany

  ];
}
