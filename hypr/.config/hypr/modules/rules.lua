local primaryMonitor = os.getenv("MONITOR_PRIMARY") or ""
-- Workspace Rules
hl.workspace_rule({ workspace = "special:terminalScratchpad", on_created_empty = terminal })
hl.workspace_rule({ workspace = "name:browser", on_created_empty = browser })
hl.workspace_rule({ workspace = "name:terminal", on_created_empty = terminal })
hl.workspace_rule({ workspace = "name:emacs", on_created_empty = emacs })
hl.workspace_rule({ workspace = "1", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "2", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "3", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "4", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "5", monitor = primaryMonitor })

hl.window_rule({
    name = "OnFullscreen",
    match = {
        fullscreen = true
    },
    border_size = 4,
    border_color = "rgb(FF0000) rgb(880808)",
    rounding = 1
})

hl.window_rule({
    name = "TransparentSpecialWorkspace",
    match = {
        workspace = "special:terminalScratchpad"
    },
    opacity = "0.6 override 0.5 override 0.4 override"
})

hl.window_rule({
    name = "Named workspace has max one tiled window",
    match = { workspace = "n[true]w[t1]" },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.8" }
})

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
    size = { "monitor_w * 0.5", "monitor_h * 0.5" },
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
