#Setting variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
##Default programs
export GUIEDITOR="emacsclient -c --eval '(setq doom-modeline-icon(display-graphic-p))'"
export EDITOR="${GUIEDITOR:-nvim}"
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILEMANAGER="nautilus"
##cleanup
export ZDOTDIR="$HOME/.config/zsh"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="/dev/null"
##golang
#setting the gopath
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
#setting paths
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/shell-color-scripts
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:~/.emacs.d/bin
## PATH Variables# set PATH so it includes users private bin if it existis
if [ -d "$HOME/.local/bin/" ] ;then
    PATH="$HOME/.local/bin/:$PATH"
fi

