-- set :w and :q capital insensitive
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "q", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("Qw", "wq", { nargs = 0 })

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

-- Find start of the current word
vim.keymap.set("n", "z", "F ", opts)

-- Select line
vim.keymap.set("n", "vv", "_v$", opts)
-- Select all file
vim.keymap.set("n", "vga", "gg_vG$", opts)

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Toggle Treesitter context
vim.keymap.set("n", "<leader>tc", "<cmd>TSContext toggle<CR>", { desc = "Toggle Treesitter Context" })

-- Restart Lsp
vim.keymap.set("n", "<leader>rl", "<cmd>LspRestart<CR>", { desc = "Restart Lsp" })

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)

vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)

-- -- Buffers
-- vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
-- vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
-- vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
-- vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement

-- Window management
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-j>", "vv <cmd> m .+1<CR>==", opts)

vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<A-k>", "vv <cmd> m .-2<CR>==", opts)

-- Paste from 0 register (only yank)
vim.keymap.set("v", "p", '"0p', opts)
vim.keymap.set("n", "p", '"0p', opts)

-- Paste from unnamed register (yank+delete,everything)
vim.keymap.set("v", "<leader>p", '""p', opts)
vim.keymap.set("n", "<leader>p", '""p', opts)

-- Paste from + register (system clipboard)
vim.keymap.set("v", "<A-p>", '"+p', opts)
vim.keymap.set("n", "<A-p>", '"+p', opts)

-- Delete selection into the blackhole register
vim.keymap.set("v", "<leader>d", '"_d', opts)

-- Delete character into the blackhole register
vim.keymap.set("v", "<leader>x", '"_x', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(0)
	else
		vim.diagnostic.disable(0)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })

vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })
