export EDITOR="nvim"
export BROWSER="firefox"
export BROWSER2="zen-browser"
export MANPAGER="nvim +Man!"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

MONTH=$(date +%Y-%m)
SS_DIR="$HOME/pictures/screenshots/"$MONTH
mkdir -p $SS_DIR
export HYPRSHOT_DIR=$SS_DIR

export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
export OBS_WEBSOCKET_URL=obsws://localhost:9911/0yimrTxB8dV5A7KY

export GOPATH="$XDG_CONFIG_HOME/go"
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export PATH=$HOME/.dotnet/tools:$PATH
