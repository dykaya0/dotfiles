local on_attach = require("core.keymaps").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global lsp config
vim.lsp.config("*", { 
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lsp.servers.lua_ls")()
require("lsp.servers.ts_ls")()
require("lsp.servers.gopls")()
require("lsp.servers.clangd")()
require("lsp.servers.bashls")()
require("lsp.servers.dockerls")()
require("lsp.servers.jsonls")()

vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"gopls",
	"clangd",
	"bashls",
	"dockerls",
	"jsonls",
})

-- Efmls Configuration
--- Register linters and formatters per language
    local languages = {
	    sh = {
		    require('efmls-configs.linters.shellcheck'),
		    require('efmls-configs.formatters.shfmt'),
	    },
	    go = {
		    require('efmls-configs.linters.go_revive'),
		    require('efmls-configs.formatters.gofumpt'),
	    },
	    c = {
		    require("efmls-configs.linters.cpplint"),
		    require('efmls-configs.formatters.clang_format'),
	    },
	    cpp = {
		    require("efmls-configs.linters.cpplint"),
		    require('efmls-configs.formatters.clang_format'),
	    },
	    lua = {
		    require("efmls-configs.linters.luacheck"),
		    require('efmls-configs.formatters.stylua'),
	    },
	    typescript = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },
	    typescriptreact = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },	
	    javascript = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },
	    javascriptreact = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },	
	    vue = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },
	    svelte = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.prettier'),
	    },
	    json = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.fixjson'),
	    },	
	    jsonc = {
		    require('efmls-configs.linters.eslint_d'),
		    require('efmls-configs.formatters.fixjson'),
	    },
	    html = {
		    require('efmls-configs.formatters.prettier'),
	    },
	    css = {
		    require('efmls-configs.formatters.prettier'),
	    },
	    docker = {
		    require('efmls-configs.formatters.prettier'),
	    },
    }

-- Using the defaults provided by efm
    -- local languages = require('efmls-configs.defaults').languages()
    local efmls_config = {
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { '.git/' },
        languages = languages,
      },
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
      },
    }
    
    -- If nvim >= 0.11 
    vim.lsp.config('efm', vim.tbl_extend('force', efmls_config, {
      cmd = { 'efm-langserver' },
    }))
