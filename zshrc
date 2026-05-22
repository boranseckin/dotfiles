export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="custom"
ZSH_COMPDUMP="$ZSH/cache/.zcompdump"

plugins=(
  sudo
  extract
  macos
  ssh-agent
  eza
  fzf
  jj
  zoxide
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

alias cat='bat';
alias grep='rg';
alias vim="nvim";
alias ssh="kitten ssh";

alias myip="curl icanhazip.com";
alias myip4="curl -4 icanhazip.com";
alias myip6="curl -6 icanhazip.com";

# GPG
export GPG_TTY=$(tty);

# Homebrew
export HOMEBREW_NO_ENV_HINTS=true;

# Python
export PYENV_ROOT="$HOME/.pyenv";
export PATH="$PYENV_ROOT/bin:$PATH";

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)";
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)";
fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1;

# Rust
. "$HOME/.cargo/env";

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
