return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "creativenull/efmls-configs-nvim", opts = {} },
	},
	config = function()
		require("lsp.diagnostic").setup()
		require("lsp.config")
	end,
}
