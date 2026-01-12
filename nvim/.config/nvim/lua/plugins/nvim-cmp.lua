return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim", -- Adds pictorgrams/icons to the completion menu
		"saadparwaiz1/cmp_luasnip", -- Enables LuaSnip as a source for nvim-cmp autocompletion
		"L3MON4D3/LuaSnip", -- Snippet engine for Neovim
		"rafamadriz/friendly-snippets", -- Large collection of pre-made snippets for various languages
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for LSP-based autocompletion
		"hrsh7th/cmp-buffer", -- nvim-cmp source for words from the current buffer
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths
	},

	config = function()
		local lspkind = require("lspkind")
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					menu = {
						luasnip = "",
						buffer = "",
						path = "",
						nvim_lsp = "",
					},
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-c>"] = cmp.mapping.abort(),
				-- ["<CR>"] = cmp.mapping.complete(),
			}),

			sources = {
				{ name = "luasnip" },
				{ name = "nvim-lsp" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
	end,
}
