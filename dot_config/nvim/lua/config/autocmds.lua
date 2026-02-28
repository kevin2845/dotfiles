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

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyUpdate",
  group = vim.api.nvim_create_augroup("chezmoi_update_lock", { clear = true }),
  callback = function()
    local lock_file = vim.fn.stdpath("config") .. "/lazy-lock.json"

    -- A)chezmoi SOURCE to track the new lock:
    vim.fn.system({ "chezmoi", "add", lock_file })

    -- B)Force APPLY the lock from chezmoi source to target:
    -- vim.fn.system({ "chezmoi", "apply", lock_file })
  end,
})

