{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
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

    };

  };

  programs.gh = {
    enable = true;
    gitProtocol = "ssh";
  };
}
