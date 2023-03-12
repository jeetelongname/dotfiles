{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      co = "checkout";
      s = "status";
      yolo = ''
        !git commit -m "$(curl -s whatthecommit.com/index.txt)"
      ''; # we take part in a modicum of tomfoolery

    };

    delta = {
      enable = true;
      options = {
        plus-color = "#012800";
        minus-color = "#340001";
        theme = "Monokai Extended";

      };

    };

    includes = [{ path = "~/gitconfig.hidden"; }];

    userEmail = "jeetelongname@gmail.com";
    userName = "Jeetaditya Chatterjee";

    signing = {
      key = "BA34D124";
      gpgPath = "/usr/bin/gpg";
      signByDefault = true;
    };

    extraConfig = {
      github.user = "jeetelongname";
      color.ui = "auto";
      init.defaultBranch = "senpai"; # because I am a child
      # commit.gpgSign = true;
      tag.gpgSign = true;

    };

  };

  programs.gh = {
    enable = true;
    settings.gitProtocol = "ssh";
  };
}
