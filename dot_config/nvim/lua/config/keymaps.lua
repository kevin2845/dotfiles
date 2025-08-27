--[[
  Global Keymaps Configuration
  Non-plugin specific keymaps
--]]

-- ===========================
-- MOVEMENT & NAVIGATION (ThePrimeagen style)
-- ===========================
-- Move selected text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Fix cursor when appending line
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and maintain cursor position" })

-- Keep cursor in middle for half page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- ===========================
-- EDITING OPERATIONS
-- ===========================

-- Paste without overwriting register
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- Delete to void register
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete to void register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete to void register" })

-- Replace word under cursor
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "[R]eplace [W]ord" })

-- Visual block mode
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = "Visual block mode" })

-- ===========================
-- WINDOW NAVIGATION
-- ===========================

-- Window navigation (fallback for tmux-navigator)
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to down window" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to up window" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })

-- ===========================
-- WINDOW MANAGEMENT
-- ===========================

vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "[W]indow [S]plit horizontal" })
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "[W]indow [V]split vertical" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "[W]indow [C]lose" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "[W]indow [O]nly (close others)" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow [=]equalize" })

-- Window resizing
vim.keymap.set("n", "<leader>w+", "<cmd>resize +5<cr>", { desc = "[W]indow [+]increase height" })
vim.keymap.set("n", "<leader>w-", "<cmd>resize -5<cr>", { desc = "[W]indow [-]decrease height" })
vim.keymap.set("n", "<leader>w>", "<cmd>vertical resize +5<cr>", { desc = "[W]indow [>]increase width" })
vim.keymap.set("n", "<leader>w<", "<cmd>vertical resize -5<cr>", { desc = "[W]indow [<]decrease width" })

-- ===========================
-- BUFFER/TAB NAVIGATION
-- ===========================

-- Buffer/Tab navigation (moved here from plugin-specific section)
vim.keymap.set("n", "<leader><TAB>", "<cmd>bnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<CR>", { desc = "Close tab" })

-- ===========================
-- FILE OPERATIONS
-- ===========================

vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "[F]ile [S]ave" })
vim.keymap.set("n", "<leader>fq", "<cmd>q<CR>", { desc = "[F]ile [Q]uit" })
vim.keymap.set("n", "<leader>W", "<cmd>w<CR>", { desc = "Save file" })

-- ===========================
-- SEARCH & UTILITY
-- ===========================

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "[N]o [H]ighlight" })
vim.keymap.set("n", "<leader>H", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- ===========================
-- TERMINAL
-- ===========================

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ===========================
-- SPLIT NAVIGATION (Kickstart defaults - may conflict with tmux-navigator)
-- ===========================

-- NOTE: These will be overridden by tmux-navigator if it's loaded
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ===========================
-- MISCELLANEOUS
-- ===========================

-- Database UI
vim.keymap.set("n", "<leader>`", ":DBUIToggle<CR>", { desc = "Database UI" })

-- Git operations (simple terminal commands)
vim.keymap.set("n", "<leader>gc", function()
	vim.cmd("terminal git commit")
end, { desc = "Git commit" })

vim.keymap.set("n", "<leader>gp", function()
	vim.cmd("terminal git push")
end, { desc = "Git push" })

vim.keymap.set("n", "<leader>gl", function()
	vim.cmd("terminal git log --oneline")
end, { desc = "Git log" })


vim.keymap.set("n", "K",          vim.lsp.buf.hover)            -- Hover docs
vim.keymap.set("n", "gd",         vim.lsp.buf.definition)       -- Go to definition
vim.keymap.set("n", "gr",         vim.lsp.buf.references)       -- References
vim.keymap.set("n", "gI",         vim.lsp.buf.implementation)   -- Implementation
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)           -- Rename symbol
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)      -- Code action


