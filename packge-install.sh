#!/usr/bin/bash

packages=(zsh alacritty tmux neovim emacs nitrogen build-essential ## the basics (goes on any system no matter what)
          golang python3-pip rustc texlive-full markdown ## the languages and the backends that i use
          xdotool tree neofetch git aptitude pandoc bat ripgrep ## some nice commandline apps tht i use
          gnome-shell-pomodoro gnome-backgrounds dconf-editor gnome-tweaks ## GNOME apps (because i use Gnome)
          flatpak snapd ## all the apps
          ninvaders moon-buggy figlet lolcat cowsay ##games and all that fun stuff
          libavcodec-extra hplip ## libs codecs and extras
          ssh sshfs ## all the ssh
         )
echo ${packages[*]} | xargs sudo apt install -y
# wget -qO- https://git.io/papirus-icon-theme-install | sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
