{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    caddy
    firefox
    nodePackages.sass
    nodePackages.yarn

    nodePackages.js-beautify
    nodePackages.stylelint

    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.typescript-language-server

  ];
}
