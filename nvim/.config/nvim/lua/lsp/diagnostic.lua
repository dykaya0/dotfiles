local M = {}

local diagnostics_signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

M.setup = function()
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = diagnostics_signs.Error,
				[vim.diagnostic.severity.WARN] = diagnostics_signs.Warn,
				[vim.diagnostic.severity.HINT] = diagnostics_signs.Hint,
				[vim.diagnostic.severity.INFO] = diagnostics_signs.Info,
			},
		},
	})
end

return M
