#!/usr/bin env sh
packages=(
    basics=(zsh alacritty neovim emacs)
    lang=(golang python3-pip rustc texlive-full)
    term=(xdotool tree)
    GNOME=(gnome-pomadoro gnome-backgrounds gnome-paint)
    appformats=(flatpak snapd)
    games=(ninvaders moonbuggy neofetch)
)
sudo apt-get install $packages
wget -qO- https://git.io/papirus-icon-theme-install | sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

