-- Essentials
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.layout("swapwithmaster master"))

-- Execute keybindings
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(emacs))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(runScripts))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(audioSwitcherScript))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd(reloadConfigScript))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd("passrofi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(refreshWaybar))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(screenshotMenu))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(toggleWaybar))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(emacsOrgCapture))
hl.bind("ALT + C", hl.dsp.exec_cmd(clipboardHistory))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("PRINT", hl.dsp.exec_cmd(screenshotMenu .. " Monitor"))

-- Focus window
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Default workspace keybindings
for i = 1, 9 do
    local key = i
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Repeating keybindings makes sure on_created_empty is triggered(even if named workspace is empty)
-- There is a difference with this and special workspaces but too lazy to explain
local function focus_workspace_persistent_window(key_combo, workspace_name)
    hl.bind(key_combo,
        hl.dsp.focus({ workspace = 1 }))
    hl.bind(key_combo,
        hl.dsp.focus({ workspace = "name:" .. tostring(workspace_name) }))
end

-- Switch workspaces
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + S", hl.dsp.focus({ workspace = "special:terminalScratchpad" }))
focus_workspace_persistent_window(mainMod .. " + B", "browser")
focus_workspace_persistent_window(mainMod .. " + T", "terminal")
focus_workspace_persistent_window(mainMod .. " + E", "emacs")

-- Move workspace to directions
hl.bind(mainMod .. " + CTRL + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.workspace.move({ monitor = "r" }))

-- Move active window to a workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminalScratchpad" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
