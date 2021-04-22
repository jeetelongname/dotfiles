{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      co = "checkout";
      s = "status";

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

    extraConfig = {
      github.user = "jeetelongname";
      color.ui = "auto";
      init.defaultBranch = "senpai"; # because I am a child

    };

  };

  programs.gh = {
    enable = true;
    gitProtocol = "ssh";
  };
}
