# Load Modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# Completion opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu

# User configuration
setopt CORRECT
setopt auto_menu menu_complete # autocmp first menu match
setopt auto_param_slash # when dir is completed add / instead of empty space
setopt no_case_glob no_case_match # cmp is case insensitive

# Binds
bindkey -v
bindkey '^C' kill-whole-line

# Prompt
eval "$(starship init zsh)"

# Source
source <(fzf --zsh)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

eval "$(zoxide init zsh)"

_fzf_compgen_path() {
  fd --hidden --follow \
    --exclude "/.cache" \
    --exclude "~/.steam" \
    --exclude "go" \
    --exclude "node_modules" \
    . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow \
    --exclude ".git" \
    --exclude "~/.steam" \
    --exclude "go" \
    --exclude ".cache" \
    --exclude "node_modules" \
    . "$1"
}

#history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth

open_git_nvim() {
  local dir="${1:-.}"
  if [ -d "$dir/.git" ]; then
      cd "$(realpath "$dir")"
      nvim -c "Git"
  else
      printf '\033[31m%s\033[0m\n' "not a git directory"
  fi
}

# Alias
alias n="nvim"
alias zedit='nvim "$(zoxide query -i)"'
alias cd="z"
alias zd='cd "$(zoxide query -i)"'
alias cat="bat"
alias lsa="eza -a1"
alias ls="eza -1"
alias kyb="systemctl --user restart openrgb.service"
alias nb="tms ~/projects/meta/newsboat"
alias buf="nvim commandbuffer"
alias gitv='open_git_nvim'
alias git-commitandpush="git add .;git commit -m '$(date -u)';git push"

alias fzf='fd --hidden --follow --exclude ".git" --exclude ".cache" --exclude ".steam" --exclude "go" . | fzf'
alias fzd='fd --type d --hidden --follow --exclude ".git" --exclude ".cache" --exclude ".steam" . | fzf'

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit
