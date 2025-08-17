--[[
  Autocommands Configuration
  Custom autocommands and autocmd groups
--]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Additional autocommands can be added here
-- Examples:
-- - Format on save
-- - Auto-reload config files
-- - Custom file type detection
-- - etc.
