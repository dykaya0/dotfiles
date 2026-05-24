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
