{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry # dep manager
    black # formatter
    python39Packages.pyflakes # something
    python39Packages.isort # import managment
    python39Packages.nose # test 1
    python39Packages.pytest # test 2
    pipenv # venv
    python39Packages.ipython # repl
    python39Packages.python-lsp-server # ls
  ];
}
