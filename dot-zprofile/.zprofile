export EDITOR="nvim"
export TERMINAL="ghostty"
export BROWSER="librewolf"
export BROWSER2="chromium"
export MANPAGER="nvim +Man!"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/.local/bin"

SS_DIR=$HOME/pictures/screenshots/$(date +%Y-%m)
mkdir -p $SS_DIR
export HYPRSHOT_DIR=$SS_DIR

export WALLPAPER_DIR="$HOME/pictures/wallpapers"
export KEYBOARD="at-translated-set-2-keyboard"
export MONITOR_OUTPUT="eDP-1"

export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"
export OBS_WEBSOCKET_URL=obsws://localhost:9911/0yimrTxB8dV5A7KY
export GOPATH="$XDG_DATA_HOME/go"

export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export PATH=$HOME/.dotnet/tools:$PATH
export PATH="$HOME/.local/bin:$PATH"
