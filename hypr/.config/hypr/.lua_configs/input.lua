require("variables")

-- Input
hl.config({
    input = {
        numlock_by_default = true,
        follow_mouse = 1,

        kb_layout = "gb, tr",
        kb_options = "caps:escape_shifted_capslock",

        sensitivity = -0.5,
        scroll_button_lock = true,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 1.2,
        }

    }
})

-- Keybindings

local mainMod = "SUPER"

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(emacs))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(runScripts))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(audioSwitcherScript))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd(reloadConfigScript))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd(passrofi))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(refreshWaybar))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(screenshotMenu))
hl.bind(mainMod .. "ALT + C", hl.dsp.exec_cmd(clipboardHistory))
hl.bind(mainMod .. "ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. "SHIFT + W", hl.dsp.exec_cmd(toggleWaybar))
hl.bind(mainMod .. "SHIFT + N", hl.dsp.exec_cmd(emacsOrgCapture))
hl.bind(mainMod .. "SHIFT + Q", hl.dsp.exec_cmd(exit))
hl.bind(mainMod .. " + C", hl.dsp.winDow.close())
hl.bind(mainMod .. " + F", hl.dsp.fullscreen({action = "toggle"}))
hl.bind("PRINT", hl.dsp.exec_cmd(screenshotMenu .. "Monitor"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. " + RETURN", hl.dsp.window.exec_cmd(terminal))
hl.bind(mainMod .. " + M", hl.dsp.layout("swapwithmaster master"))

-- Focus window
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window
hl.bind(mainMod .. " SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " SHIFT + L", hl.dsp.window.move({ direction = "right" }))

for i = 1, 7 do
    local key = i % 6 -- 7 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch workspaces
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = 1}))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = 2}))
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = 3}))
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = 4}))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = 3}))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = 4}))
hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "previous"}))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("terminalScratchpad"))
hl.bind(mainMod .. " + mouse:276", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse:275",   hl.dsp.focus({ workspace = "e-1" }))

-- Move active window to a workspace
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminalScratchpad" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
