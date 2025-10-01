return {
	"kj-1809/previous-buffer.nvim",
	config = function()
		vim.keymap.set("n", "<Tab>", ":PreviousBuffer<CR>", { silent = true })
	end,
}
