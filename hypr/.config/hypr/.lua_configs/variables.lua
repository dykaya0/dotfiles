local xdg_config_home = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
local xdg_bin_home = os.getenv("XDG_BIN_HOME") or os.getenv("HOME") .. "/.local/bin"
mainMonitor = "DP-2"
secondMonitor = "HDMI-A-1"
browser = "librewolf --new-window"
terminal = "ghostty --working-directory=HOME"
fileManager = "thunar"
emacs = "emacsclient -c"
emacsOrgCapture = xdg_config_home .. "/hypr/scripts/emacs-org-capture.sh"
waybarConfig = xdg_config_home .. "/waybar/config-desktop.jsonc"
menu = "rofi -show drun"

-- Monitors
hl.monitor({
    output = secondMonitor,
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = mainMonitor,
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- Mirrors main monitor to any unspecified output (comment if secondMonitor is not specified to prevent override)
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
    mirror = mainMonitor,
})


-- Scripts
clipboardHistory = xdg_config_home .. "/scripts/menu/clipboard-history.sh"
refreshWaybar = xdg_config_home .. "/scripts/waybar_refresh.sh"
toggleWaybar = xdg_config_home .. "/scripts/waybar_toggle.sh"
audioSwitcherScript = xdg_config_home .. "/scripts/menu/audio-switcher.sh"
reloadConfigScript = xdg_config_home .. "/hypr/scripts/reload-config.sh"
screenshotMenu = xdg_config_home .. "/scripts/menu/screenshot-menu.sh"
runScripts = xdg_bin_home .. "/runScripts.sh"

-- Sound Effects
soundFx1 = xdg_config_home .. "/hypr/utils/sound_fx/disco_elysium-fx/physique.mp3"
soundFx2 = xdg_config_home .. "/hypr/utils/sound_fx/disco_elysium-fx/psyche.mp3"
soundFx3 = xdg_config_home .. "/hypr/utils/sound_fx/disco_elysium-fx/motorics.mp3"
soundFx4 = xdg_config_home .. "/hypr/utils/sound_fx/disco_elysium-fx/intellect.mp3"
soundFx5 = xdg_config_home .. "/hypr/utils/sound_fx/windows-fx/logon.m4a"

-- Environment Variables
hl.env("XCURSOR_SIZE","18")
hl.env("HYPRCURSOR_SIZE","18")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1")
hl.env("QT_QPA_PLATFORM","wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION","1")
hl.env("QT_QPA_PLATFORMTHEME","qt5ct")
hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
