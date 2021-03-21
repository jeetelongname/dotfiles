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
    modules/chat.nix
    modules/cli.nix
    modules/emacs.nix
    modules/email.nix
    modules/fun.nix
    modules/git.nix
    modules/guile.nix
    # modules/keyboard.nix
    modules/latex.nix
    modules/misc.nix
    modules/neovim.nix
    modules/nix.nix
    modules/python.nix
    modules/ruby.nix
    modules/shell.nix
    modules/terminal.nix
    modules/web.nix

  ];

  # autoOptimiseStore = true;
  # gc.automatic = true;
  # gc.dates = "weekly";
  # gc.options = "--delete-older-than 7d";

  # optimise.automatic = true;
  # optimise.dates = [ "weekly" ];
}
