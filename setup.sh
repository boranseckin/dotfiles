#!/bin/bash

link() {
    SRC="$PWD/$1"
    DST=$2
    #mkdir -p ${2%/*}
    ln -sfn $SRC $DST
    echo "$1 -> $2"
}

link hyperzsh.zsh-theme $ZSH/custom/themes/hyperzsh.zsh-theme
link zshrc $HOME/.zshrc
link fontconfig $XDG_CONFIG_HOME/fontconfig
link git $XDG_CONFIG_HOME/git
link tmux $XDG_CONFIG_HOME/tmux
link nvim $XDG_CONFIG_HOME/nvim
