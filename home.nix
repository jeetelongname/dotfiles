{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  imports = [ modules/terminal.nix ];

  home = {
    packages = with pkgs; [ caddy nixfmt shfmt ];
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "jeet";
    homeDirectory = "/home/jeet";

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
