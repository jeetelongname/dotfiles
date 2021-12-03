{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # servers
    nodejs
    hugo
    caddy

    # clients
    #firefox
    nyxt

    # devel
    nodePackages.sass
    nodePackages.yarn

    # formatters
    nodePackages.js-beautify

    # language servers
    nodePackages.vscode-json-languageserver-bin
    nodePackages.typescript-language-server
  ];
}
