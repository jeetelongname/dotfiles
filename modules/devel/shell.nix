{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;

    autocd = true;
    cdpath = [
      "~/.dotfiles"
      "~/code"

    ];

    dotDir = ".config/zsh";

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = ".cache/zsh/zsh_history";
      save = 10000;
      share = true;
      size = 10000;
    };

    initExtra = "source $ZDOTDIR/extra.zsh";

    zplug = {
      enable = true;

      plugins = [
        {
          name = "zdharma/fast-syntax-highlighting";
          tags = [ "defer:2" ];
        }
        {
          name = "zsh-users/zsh-autosuggestions";
          tags = [ "defer:2" ];
        }
        {
          name = "hlissner/zsh-autopair";
          tags = [ "defer:2" ];
        }
        {
          name = "jeetelongname/Yeet-theme";
          tags = [ "as:theme" "defer:1" "dir:~/code/shell/yeet-theme" ];
        }
        {
          name = "plugins/alias-finder";
          tags = [ "from:oh-my-zsh" "as:plugin" ];
        }
        { name = "MichaelAquilina/zsh-you-should-use"; }
      ];
    };
  };

  xdg.configFile = {
    "zsh/extra.zsh".source = ../../config/shell/extra.zsh;
    "zsh/functions.zsh".source = ../../config/shell/functions.zsh;
    "zsh/keys.zsh".source = ../../config/shell/keys.zsh;
    "aliases".source = ../../config/shell/aliases;

  };

  home.file = {
    ".bashrc".source = ../../config/shell/bashrc;
    ".xprofile".source = ../../config/shell/xprofile;
    ".profile".source = ../../config/shell/profile;
    ".zprofile".source = ../../config/shell/profile;

  };
}
