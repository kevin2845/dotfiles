--[[
  Terminal and Navigation Plugins
  Terminal emulators and navigation tools
--]]

return {
	-- ToggleTerm for terminal management
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>tf", "<cmd>1ToggleTerm<cr>", desc = "[T]erminal [F]loating" },
			{ "<leader>th", "<cmd>2ToggleTerm size=10 direction=horizontal<cr>", desc = "[T]erminal [H]orizontal" },
			{ "<leader>tv", "<cmd>3ToggleTerm size=30 direction=vertical<cr>", desc = "[T]erminal [V]ertical" },
			{ "<leader>tn", "<cmd>4ToggleTerm direction=tab<cr>", desc = "[T]erminal [N]ew tab" },
		},
	},

	-- Tmux Navigator for seamless navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		config = function()
			-- These keymaps will override the default <C-hjkl> mappings
			vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
			vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux navigate right" })
			vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux navigate down" })
			vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux navigate up" })
		end,
	},
}
