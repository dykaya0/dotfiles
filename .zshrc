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

# Prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Source
source <(fzf --zsh)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

eval "$(zoxide init zsh)"

_fzf_compgen_path() {
  fd --hidden --follow \
    --exclude "/.cache" \
    --exclude "node_modules" \
    . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow \
    --exclude ".git" \
    --exclude ".cache" \
    --exclude "node_modules" \
    . "$1"
}

#history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth

#Change the current working directory when exiting Yazi.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}



# Alias
alias cd="z"
alias cat="bat"
alias lsa="eza -a1"
alias ls="eza -1"

alias fzf='fd --hidden --follow --exclude ".git" --exclude ".cache" --exclude ".steam" . | fzf'
alias fzd='fd --type d --hidden --follow --exclude ".git" --exclude ".cache" --exclude ".steam" . | fzf'

