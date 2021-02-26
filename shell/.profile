#Setting variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
##Default programs
# export VISUAL="emacsclient -c --eval '(setq doom-modeline-icon(display-graphic-p))'"
export EDITOR="nvim"
export VISUAL="emacsclient -c "
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILEMANAGER="nautilus"
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma fdm=indent' -\""
# export MANPAGER="/bin/sh -c \"col -b | nvim -u '~/.config/nvim/init.man.vim' -\""
##cleanup
export ZDOTDIR="$HOME/.config/zsh"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export LESSHISTFILE="/dev/null"
##golang
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
#setting paths
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/shell-color-scripts
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:~/.config/emacs.doom/bin
#pass stuff
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
## CDPATH "sending you ~ a little less" TODO

## PATH Variables# set PATH so it includes users private bin if it existis
if [ -d "$HOME/.local/bin/" ]; then
	PATH="$HOME/.local/bin/:$PATH"
fi
if [ "$PAGER" = "most" ]; then
	PAGER="less"
fi

if [ -d $HOME/.nix-profile/etc/profile.d ]; then
	for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
		if [ -r $i ]; then
			. $i
		fi
	done
fi
export PATH="$HOME/.poetry/bin:$PATH"
#Nix (need to do more with it)
if [ -e /home/jeet/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jeet/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export PATH=$PATH:~/.nimble/bin
