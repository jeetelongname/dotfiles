#!/usr/bin env bash

packages=(zsh alacritty neovim emacs
          golang python3-pip rustc texlive-full
          xdotool tree neofetch git
          gnome-shell-pomodoro gnome-backgrounds gnome-paint dconf-editor gnome-tweaks
          flatpak snapd
          notrogen 
          ninvaders moonbuggy figlet lolcat cowsay
          libavcodec-extra)
echo ${packages[*]}
# sudo apt-get install < $packages 
# wget -qO- https://git.io/papirus-icon-theme-install | sh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
