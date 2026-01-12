return function()
	vim.lsp.config("dockerls", {
	filetypes = {
		"dockerfile",
	},
})
end
