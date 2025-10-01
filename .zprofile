export EDITOR="nvim"
export BROWSER="zen-browser"
export BROWSER2="brave"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# export GTK_THEME="Kanagawa-Dark-Dragon"
export HYPRSHOT_DIR="$HOME/Pictures/Screenshots/"
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/go/bin

export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"


eval "$(zoxide init --cmd cd zsh)"
# pnpm
export PNPM_HOME="/home/dogukan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
