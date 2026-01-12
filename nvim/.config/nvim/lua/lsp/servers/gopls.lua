return function()
	vim.lsp.config("gopls", {
	filetypes = {
		"go",
	},
})
end
