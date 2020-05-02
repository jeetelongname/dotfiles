#!/usr/bin env sh

sudo apt-get install zsh neovim emacs deja-dup python3-pip snapd gnome-tweaks herbstluftwm 
wget -qO- https://git.io/papirus-icon-theme-install | sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

