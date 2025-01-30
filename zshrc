export ZSH="$HOME/.oh-my-zsh";

ZSH_THEME="hyperzsh"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_COMPDUMP=$ZSH/cache/.zcompdump

plugins=(
  extract
  ssh-agent
  rust
  eza
  fzf
  z
)

# History
export HISTORY_IGNORE="l*|ll*|la*|ls*|eza*|cd|vim*|pwd|ps*|man*|kill*|exit|date|* --help";
setopt HIST_IGNORE_ALL_DUPS;
setopt HIST_FIND_NO_DUPS;
setopt HIST_REDUCE_BLANKS;

zstyle :omz:plugins:eza dirs-first yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent quiet yes

source $ZSH/oh-my-zsh.sh;
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Editor
export EDITOR="nvim";

# Aliases
alias cat='bat';
alias grep='rg';
alias vim="nvim";

alias pubkey="cat ~/.ssh/*.pub | wl-copy | echo 'public key copied to pasteboard'";
alias src="source ~/.zshrc";
alias cpv="rsync -ahP";
alias changes="git logs | awk '/^ [0-9]/ { f += \$1; i += \$4; d += \$6 } END { printf(\"%d files changed, %d insertions(+), %d deletions(-)\n\", f, i, d) }'";
alias diff="git diff --name-only --relative --diff-filter=d | xargs bat --diff";

alias myip="curl icanhazip.com";
alias myip4="curl -4 icanhazip.com";
alias myip6="curl -6 icanhazip.com";
