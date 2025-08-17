--[[
  Neovim Options Configuration
  All vim.o, vim.opt, and vim.g settings
--]]

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters in search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 50

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Confirm before operations that would fail due to unsaved changes
vim.o.confirm = true

-- ===========================
-- ThePrimeagen/Kevin's Custom Options
-- ===========================

-- Tab settings (4 spaces)
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Smart indent
vim.o.smartindent = true

-- Line wrapping (disable it)
vim.o.wrap = false

-- Undo directory setup
vim.o.swapfile = false
vim.o.backup = false
local undodir = os.getenv("HOME") .. "/.vim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir

-- Search settings
vim.o.hlsearch = false -- Don't keep search highlighted
vim.o.incsearch = true -- Show search results as you type

-- Optional: Color column (uncomment if you want a visual line at 80 chars)
-- vim.o.colorcolumn = "80"
