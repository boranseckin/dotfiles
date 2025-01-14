export ZSH="/Users/boran/.oh-my-zsh";

ZSH_THEME="hyperzsh"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

plugins=(
  extract
  macos
  thefuck
  rust
  fzf
  z
  zsh-syntax-highlighting
)

# History
export HISTORY_IGNORE="l*|ll*|la*|ls*|eza*|cd|vim*|pwd|ps*|man*|kill*|exit|date|* --help";
setopt HIST_IGNORE_ALL_DUPS;
setopt HIST_FIND_NO_DUPS;
setopt HIST_REDUCE_BLANKS;

source $ZSH/oh-my-zsh.sh;

# Aliases
alias l='eza -la';
alias ll='eza -l';
alias la='eza -lA';
alias lt='eza -lT';
alias lta='eza -lTA';

alias cat='bat';

alias vim="nvim";
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'";
alias src="source ~/.zshrc";
alias nl="npm list --depth=0 2>/dev/null";
alias nlg="npm list -g --depth=0 2>/dev/null";
alias cpv="rsync -ahP";
alias changes="git logs | awk '/^ [0-9]/ { f += \$1; i += \$4; d += \$6 } END { printf(\"%d files changed, %d insertions(+), %d deletions(-)\n\", f, i, d) }'";
alias diff="git diff --name-only --relative --diff-filter=d | xargs bat --diff";

alias myip="curl icanhazip.com";
alias myip4="curl -4 icanhazip.com";
alias myip6="curl -6 icanhazip.com";

# Editor
export EDITOR="nvim";

# GPG
export GPG_TTY=$(tty);

# Docker
export DOCKER_SCAN_SUGGEST=false;

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

# pico
export PICO_SDK_PATH="$HOME/.pico-sdk/sdk/2.0.0"
