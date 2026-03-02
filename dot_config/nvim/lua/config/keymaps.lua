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
vim.keymap.set(
	"n",
	"<leader>r",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Replace word under cursor" }
)
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

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "[Q]uit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite file" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force [Q]uit" })

-- ===========================
-- SEARCH & UTILITY
-- ===========================
-- stylua: ignore start

vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File [E]xplorer" })


vim.keymap.set("n", "<leader>sf", function() require("snacks").picker.smart({layout = { preset = "default"}}) end, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", function() require("snacks").picker.grep({layout = { preset = "default"}}) end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sb", function() require("snacks").picker.buffers({layout = { preset = "vscode"}}) end, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>:", function() require("snacks").picker.command_history() end, { desc = ": Command History" })
vim.keymap.set("n", "<leader>sk", function() require("snacks").picker.keymaps() end, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sw", function() require("snacks").picker.grep_word() end, { desc = "[S]earch [W]ord" })
vim.keymap.set("n", "<leader>sc", function() require("chezmoi.pick").snacks() end, { desc = "[S]earch [C]onfig Files" })

-- stylua: ignore end

-- Buffer fuzzy search
vim.keymap.set("n", "<leader>f", function()
	require("snacks").picker.lines({
		title = "Current Buffer",
		layout = { preset = "dropdown" },
	})
end, { desc = "[F]uzzy search current buffer" })

-- Search in open files (buffers)
vim.keymap.set("n", "<leader>ss", function()
	require("snacks").picker.grep_buffers({
		title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch in Open Files" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "[N]o [H]ighlight" })
vim.keymap.set("n", "<leader>H", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })


-- ===========================
-- TERMINAL
-- ===========================

-- Exit terminal mode
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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

-- UndoTree Toggle
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndo tree" })

-- GlobalNote Toggle
vim.keymap.set("n", "<leader>n", "<cmd>GlobalNote<CR>", { desc = "[N]otes" })

-- Database UI Toggle
vim.keymap.set("n", "<leader>`", ":DBUIToggle<CR>", { desc = "Database UI" })

-- Autoformatting 
vim.keymap.set("n", "<leader>=", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, { desc = "Format buffer" })

-- ===========================
-- COMMENTING OPERATIONS
-- ===========================
-- Comment Line
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })

-- Comment Selection
vim.keymap.set("v", "<leader>/", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment selection" })

-- Comment Line (Block Comment)
vim.keymap.set("n", "<leader>?", function()
	require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle block comment" })

-- Comment Selection (Block Comment)
vim.keymap.set("v", "<leader>?", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end, { desc = "Toggle block comment selection" })

-- ===========================
-- GIT OPERATIONS
-- ===========================
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

vim.keymap.set("n", "<leader>Gc", function()
	vim.cmd("terminal git commit")
end, { desc = "Git commit" })

vim.keymap.set("n", "<leader>Gp", function()
	vim.cmd("terminal git push")
end, { desc = "Git push" })

vim.keymap.set("n", "<leader>Gl", function()
	vim.cmd("terminal git log --oneline")
end, { desc = "Git log" })

vim.keymap.set("n", "K", vim.lsp.buf.hover) -- Hover docs
vim.keymap.set("n", "gd", vim.lsp.buf.definition) -- Go to definition
vim.keymap.set("n", "gr", vim.lsp.buf.references) -- References
vim.keymap.set("n", "gI", vim.lsp.buf.implementation) -- Implementation
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename) -- Rename symbol
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action) -- Code action
