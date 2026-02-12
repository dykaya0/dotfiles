local diagnostics_signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostics_signs.Error,
            [vim.diagnostic.severity.WARN] = diagnostics_signs.Warn,
            [vim.diagnostic.severity.HINT] = diagnostics_signs.Hint,
            [vim.diagnostic.severity.INFO] = diagnostics_signs.Info,
        },
    },
    -- virtual_lines = {
    --     current_line = true
    -- }
})
