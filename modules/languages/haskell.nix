{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
    ghcid
    cabal-install
    haskell-language-server
    # haskellPackages.brittany

  ];
}
