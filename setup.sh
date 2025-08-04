#!/bin/bash

link() {
  SRC="$PWD/$1"
  DST=$2
  #mkdir -p ${2%/*}
  ln -sfn $SRC $DST
  echo "$1 -> $2"
}

mkdir -p $HOME/.config
[[ ! -n "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME=$HOME/.config

link custom.zsh-theme $ZSH/custom/themes/custom.zsh-theme
link zshrc $HOME/.zshrc
link git $XDG_CONFIG_HOME/git
link tmux $XDG_CONFIG_HOME/tmux
link nvim $XDG_CONFIG_HOME/nvim
