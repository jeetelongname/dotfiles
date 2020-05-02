#!/usr/bin env sh

basics=(zsh alacritty neovim emacs)
code=(golang python3-pip rustc)
GNOME=(gnome-pomadoro gnome-backgrounds gnome-paint)

sudo apt-get install 
wget -qO- https://git.io/papirus-icon-theme-install | sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

