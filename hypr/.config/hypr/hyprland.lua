local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
local xdg_bin_home = os.getenv("XDG_BIN_HOME") or os.getenv("HOME") .. "/.local/bin"

mainMod = "SUPER"

mainMonitor = "DP-2"
secondMonitor = "HDMI-A-1"

browser = "librewolf --new-window"
terminal = "ghostty --working-directory=HOME"
menu = "rofi -show drun"
fileManager = "thunar"
emacs = "emacsclient -c"
emacsOrgCapture = xdg_config_home .. "/hypr/scripts/emacs-org-capture.sh"
waybarConfig = xdg_config_home .. "/waybar/config-desktop.jsonc"

-- Scripts
clipboardHistory = xdg_config_home .. "/scripts/menu/clipboard-history.sh"
refreshWaybar = xdg_config_home .. "/scripts/waybar_refresh.sh"
toggleWaybar = xdg_config_home .. "/scripts/waybar_toggle.sh"
audioSwitcherScript = xdg_config_home .. "/scripts/menu/audio-switcher.sh"
reloadConfigScript = xdg_config_home .. "/hypr/scripts/reload-config.sh"
autostartOther = xdg_config_home .. "/hypr/scripts/autostart-other.sh"
dependencyCheck = xdg_config_home .. "/hypr/scripts/dependency-check.sh"
screenshotMenu = xdg_config_home .. "/scripts/menu/screenshot-menu.sh"
runScripts = xdg_bin_home .. "/runScripts.sh"

require("modules.autostart")
require("modules.general")
require("modules.monitors")
require("modules.rules")
require("modules.keybinds")
