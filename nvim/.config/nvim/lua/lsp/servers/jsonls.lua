return function()
	vim.lsp.config("jsonls", {
	filetypes = {
		"json",
		"jsonc",
	},
})
end
