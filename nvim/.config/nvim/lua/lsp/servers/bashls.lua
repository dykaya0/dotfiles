return function()
	vim.lsp.config("ts_ls", {
	filetypes = {
		"sh",
		"bash",
		"zsh",
	},
})
end
