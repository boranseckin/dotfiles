_user_host() {
  if [[ $(whoami) =~ \([-a-zA-Z0-9\.]+\) ]]; then
    me="%n@%m"
  elif [[ logname != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%F{yellow}$me%f: "
  fi
}

_vcs_status() {
    local ref="self.change_id().shortest(3)"

    jj > /dev/null 2>&1 \
      && jj_prompt_template_raw "if(self.empty(), \"%F{green}\", \"%F{magenta}\") ++ $ref ++ \" \"" \
      || echo -n "$(git_prompt_info)$(_omz_git_prompt_status)"

    echo -n "%f"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{magenta}%f "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{white}󱈗%f "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_ADDED="%F{cyan}󰻭%f "
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{yellow}󰷉%f "
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}󱀷%f "
ZSH_THEME_GIT_PROMPT_RENAMED="%F{blue}󰬳%f "
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{cyan}%f "
ZSH_THEME_GIT_PROMPT_AHEAD="%F{blue}%f "
ZSH_THEME_GIT_PROMPT_BEHIND="%F{blue}%f "
ZSH_THEME_GIT_PROMPT_DIVERGED="%F{blue}%f "


# The prompt
PROMPT='$(_user_host)%F{blue}%1~/ $(_vcs_status)➜ '

# Adapted from https://github.com/tylerreckart/hyperzsh
# PROMPT='$(_user_host)$(_python_venv)%{$fg[blue]%}%c/ $(git_prompt_info)%{$reset_color%}$(git_prompt_status)➜ '
