local profile = os.getenv("MONITOR_PROFILE") or ""
local outputs = {}
for out in profile:gmatch("[^,]+") do outputs[#outputs + 1] = out end

-- Env var is not set
if #outputs == 0 then
    hl.monitor({
        output = "",
        mode = "preferred",
        position = "auto",
        scale = "auto",
    })
else
    for i, out in ipairs(outputs) do
        hl.monitor({
            output = out,
            mode = "preferred",
            position = "auto",
            scale = "auto",
        })
    end
end
