--[[
  Kevin's Neovim Configuration
  Based on Kickstart.nvim with ThePrimeagen-style customizations
  
  Entry point - loads all configuration modules
--]]

-- Set leader keys before loading anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set Nerd Font flag
vim.g.have_nerd_font = false

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim and load plugins
require("lazy").setup({
	-- Import all plugin modules
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.coding" },
	{ import = "plugins.git" },
	{ import = "plugins.terminal" },
	
	-- Utility plugins that don't need their own modules
	"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
