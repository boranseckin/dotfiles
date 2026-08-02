#!/bin/bash

link() {
  SRC="$PWD/$1"
  DST=$2
  mkdir -p "${2%/*}"
  ln -sfn "$SRC" "$DST"
  echo "$1 -> $2"
}

link custom.zsh-theme "$ZSH"/custom/themes/custom.zsh-theme
link zshrc "$HOME"/.zshrc
link fontconfig "$XDG_CONFIG_HOME"/fontconfig
link hypr "$XDG_CONFIG_HOME"/hypr
link quickshell "$XDG_CONFIG_HOME"/quickshell
link rofi "$XDG_CONFIG_HOME"/rofi
link kitty "$XDG_CONFIG_HOME"/kitty
link git "$XDG_CONFIG_HOME"/git
link tmux "$XDG_CONFIG_HOME"/tmux
link nvim "$XDG_CONFIG_HOME"/nvim
link logiops "$XDG_CONFIG_HOME"/logiops
link dunst "$XDG_CONFIG_HOME"/dunst
link obsidian/user-flags.conf "$XDG_CONFIG_HOME"/obsidian/user-flags.conf
