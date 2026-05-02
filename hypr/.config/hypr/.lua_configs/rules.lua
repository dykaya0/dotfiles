require("variables")
-- Workspace Rules
hl.workspace_rule({ workspace = "special:terminalScratchpad", on_created_empty = terminal, default = true, persistent = true })
hl.workspace_rule({ workspace = "1", monitor = mainMonitor, default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = mainMonitor, default = true, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = mainMonitor, default = true, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = mainMonitor, default = true, persistent = true })
hl.workspace_rule({ workspace = "5", monitor = mainMonitor, default = true, persistent = true })
hl.workspace_rule({ workspace = "6", monitor = secondMonitor, default = true, persistent = true })

local activeOpacity = 0.6
local inactiveOpacity = 0.5
local fullscreenOpacity = 0.5

hl.window_rule({
    name = "OnFullscreen",
    match = {
        fullscreen = true
    },
    border_size = 10,
    border_color = "rgb(FF0000) rgb(880808)",
    rounding = 1
})

-- hl.window_rule({
--   name = "TerminalScratchpadOpacity",
--   match = {
--     workspace = "special:terminalScratchpad"
--   },
--   opacity = "activeOpacity override inactiveOpacity override fullscreenOpacity override"
-- })

local float_classes = table.concat({
    "org\\.pulseaudio\\.pavucontrol",
    "org\\.gnome\\.Calculator",
    "org\\.kde\\.kclock",
    "blueman-manager",
    "kitty",
}, "|")
hl.window_rule({
    name = "FloatingApps",
    match = {
        class = float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.5", "monitor_h * 0.6" }
})

local bigger_float_classes = table.concat({
    "anki",
    "thunar",
    "Nsxiv",
    "nm-connection-editor",
    "hyprland-share-picker",

}, "|")
hl.window_rule({
    name = "BiggerFloatingApps",
    match = {
        class = bigger_float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.8" }
})

hl.window_rule({
    name = "SpecialEmacsWindow",
    match = {
        title = "special-emacs"
    },
    float = true,
    size = { "monitor_w * 0.5", "monitor_h * 0.5" }
    move = { "monitor_w * 0.5", "monitor_h * 0.5" }
})

hl.window_rule({
    name = "ObsStudioOnSpecificWorkspace",
    match = {
        class = "com.obsproject.Studio"
    },
    workspace = 5,
    no_initial_focus = true,
})

hl.window_rule({
    name = "MsTeamsOnSpecificWorkspace",
    match = {
        class = "teams-for-linux"
    },
    workspace = 6,
    no_initial_focus = true,
})

hl.window_rule({
    name = "DiscordOnSpecificWorkspace",
    match = {
        class = "discord"
    },
    workspace = 6,
    no_initial_focus = true,
})
