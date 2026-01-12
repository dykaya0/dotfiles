return function()
	vim.lsp.config("clangd", {
		cmd = {
			"clangd"
		},
		filetypes = {
			"c",
			"cpp",
		},
})
end
