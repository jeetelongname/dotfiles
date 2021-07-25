{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jeet";
    homeDirectory = "/home/jeet";

    # TODO move this out of here
    packages = with pkgs; [ gimp ];

    stateVersion = "21.05";
  };

  imports = [
    # modules/gtk.nix # I would rather have my de handle this
    # modules/keyboard.nix
    modules/devel/git.nix
    modules/devel/latex.nix
    modules/devel/shell.nix
    modules/editors/neovim.nix
    modules/languages/cc.nix # FIXME: clang is being a pain meaning I don't have clangd
    modules/languages/haskell.nix
    modules/languages/python.nix
    modules/languages/racket.nix
    modules/languages/ruby.nix
    modules/chat.nix
    modules/cli.nix
    modules/email.nix
    modules/fun.nix
    modules/misc.nix
    modules/nix.nix
    modules/terminal.nix
    modules/web.nix
    modules/editors/emacs.nix
  ];

  # autoOptimiseStore = true;
  # gc.automatic = true;
  # gc.dates = "weekly";
  # gc.options = "--delete-older-than 7d";

  # optimise.automatic = true;
  # optimise.dates = [ "weekly" ];
}
