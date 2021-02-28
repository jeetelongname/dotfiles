{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.file.".config/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  imports = [
    modules/cli.nix
    modules/fun.nix
    modules/git.nix
    modules/email.nix
    modules/misc.nix
    modules/neovim.nix
    modules/terminal.nix

  ];

  home = {
    username = "jeet";
    homeDirectory = "/home/jeet";

    packages = with pkgs; [ caddy nixfmt shfmt ];
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.05";
  };
}
