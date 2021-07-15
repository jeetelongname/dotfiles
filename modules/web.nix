{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # server
    caddy

    # clients
    firefox
    nyxt

    # devel
    nodePackages.sass
    nodePackages.yarn

    # formatters
    nodePackages.js-beautify
    nodePackages.stylelint

    # language servers
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.typescript-language-server
  ];
}
