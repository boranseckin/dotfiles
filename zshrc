export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="custom"
ZSH_COMPDUMP="$ZSH/cache/.zcompdump"

plugins=(
  sudo
  extract
  ssh-agent
  eza
  fzf
  jj
  zoxide
  zsh-syntax-highlighting
)

export HISTORY_IGNORE="l*|ll*|la*|ls*|eza*|cd|z|z *|vim*|pwd|ps*|man*|tldr*|tldx*|which*|printenv*|kill*|exit|date|* --help|jj"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt NO_BEEP

zstyle :omz:plugins:eza dirs-first yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent quiet yes

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

alias cat='bat'
alias grep='rg'
alias vim="nvim"
alias ssh="kitten ssh"

alias myip="curl icanhazip.com"
alias myip4="curl -4 icanhazip.com"
alias myip6="curl -6 icanhazip.com"
