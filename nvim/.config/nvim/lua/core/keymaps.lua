-- set common commands case insensitive
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "q", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WA", "wa", { nargs = 0 })
vim.api.nvim_create_user_command("Wa", "wa", { nargs = 0 })

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

-- LSP Keymaps
local M = {}
M.on_attach = function(client, bufnr)
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	-- Rename the variable
	map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

	-- Execute a code action
	map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

	-- Find references for the word under the cursor.
	map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

	-- Jump to the implementation of the word under the cursor.
	map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

	-- Jump to the definition of the word under the cursor.
	map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

	-- Jump to the definition of the word under the cursor in vertical split.
	map("gd", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "[G]oto [D]efinition")

	-- Jump to the declaration of the word under the cursor.
	map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Fuzzy find all the symbols in your current document.
	--  Symbols are things like variables, functions, types, etc.
	map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

	-- Hover Documentation
	map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation")
end

-- Select line
vim.keymap.set("n", "vv", "_v$", opts)
-- Select all file
vim.keymap.set("n", "vga", "gg_vG$", opts)

-- Open oil.nvim file explorer as floating window
vim.keymap.set("n", "`", function()
	require("oil").toggle_float()
end, { desc = "Toggle Oil floating window" })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Toggle Treesitter context
vim.keymap.set("n", "<leader>tc", "<cmd>TSContext toggle<CR>", { desc = "Toggle Treesitter Context" })

-- Restart Lsp
vim.keymap.set("n", "<leader>rl", "<cmd>LspRestart<CR>", { desc = "Restart Lsp" })

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- Center screen when vertical scroll and find
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Resize splits with arrows
-- Buffers Navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", opts) -- Next buffer
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", opts) -- Previous buffer

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement

-- Splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- vertical split
vim.keymap.set("n", "<leader>ss", ":close<CR>", opts) -- close current split window

--- Navigate
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", opts)
--- Resize
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move line up and down
vim.keymap.set({ "n", "v" }, "<A-j>", ":m .+1<CR>==", opts) -- Move line down
vim.keymap.set({ "n", "v" }, "<A-k>", ":m .-2<CR>==", opts) -- Move line up

-- Better J Behaviour
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Paste from unnamed register (only yanked)
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', opts)

-- Paste from + register (system clipboard)
vim.keymap.set("v", "<A-p>", '"+p', opts)
vim.keymap.set("n", "<A-p>", '"+p', opts)

-- Delete character into the blackhole register
vim.keymap.set({ "n", "v" }, "x", '"_x', opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

return M
