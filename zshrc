export ZSH="/Users/boran/.oh-my-zsh"

ZSH_THEME="hyperzsh"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  git-flow
  nvm
  brew
  extract
  npm
  nvm
  yarn
  macos
  sudo
  docker
  docker-compose
  colored-man-pages
  kubectl
  rsync
  z
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias cydia="cd /Users/boran/Cydia";
alias zshrc="vim ~/.zshrc";
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'";
alias src="source ~/.zshrc";
alias nl="npm list --depth=0 2>/dev/null";
alias nlg="npm list -g --depth=0 2>/dev/null";
alias myip="curl icanhazip.com";
alias myip4="curl -4 icanhazip.com";
alias myip6="curl -6 icanhazip.com";
alias cpv="rsync -ahP"
alias changes="git logs | awk '/^ [0-9]/ { f += \$1; i += \$4; d += \$6 } END { printf(\"%d files changed, %d insertions(+), %d deletions(-)\n\", f, i, d) }'"
alias locload="launchctl load /Users/boran/Developer/wifiUpdater/com.boranseckin.wifiUpdater.plist"
alias locunload="launchctl unload /Users/boran/Developer/wifiUpdater/com.boranseckin.wifiUpdater.plist"

# History
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

# GPG
export GPG_TTY=$(tty)

# Docker
export DOCKER_SCAN_SUGGEST=false

# Homebrew
export HOMEBREW_NO_ENV_HINTS=true

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
