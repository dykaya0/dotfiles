return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			styles = {
				comments = { italic = false },
			},
		})
		vim.o.termguicolors = true
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
