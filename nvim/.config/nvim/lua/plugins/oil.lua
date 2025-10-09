return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,

			keymaps = {
				["<CR>"] = "actions.select",
				["<BS>"] = { "actions.parent", mode = "n" },
				["`"] = {
					callback = function()
						require("oil").toggle_float()
					end,
					mode = "n",
				},
			},
			float = {
				padding = 4,
				max_width = 0.7,
				max_height = 0.7,
			},
		})
	end,
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
