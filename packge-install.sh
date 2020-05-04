#!/usr/bin env sh
packages=(
    basics=(zsh alacritty neovim emacs)
    lang=(golang python3-pip rustc texlive-full)
    term=(xdotool tree neofetch)
    GNOME=(gnome-shell-pomodoro gnome-backgrounds gnome-paint)
    appformats=(flatpak snapd)
    games=(ninvaders moonbuggy)
)

sudo apt-get install $packages 
wget -qO- https://git.io/papirus-icon-theme-install | sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

