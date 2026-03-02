--[[
  Editor Enhancement Plugins
  File explorer, fuzzy finder, and other editor tools
--]]

return {
	-- Telescope (fuzzy finder)
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup()
		end,
	},

	-- UndoTree
	{
		"mbbill/undotree",
	},

	-- Global Note
	{
		"backdround/global-note.nvim",
		opts = {},
	},

	-- Comment plugin
	{
		"numToStr/Comment.nvim",
		opts = {},
	},

	-- Neorg (Note taking)
	{
		"nvim-neorg/neorg",
		version = "*",
		build = ":Neorg sync-parsers",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/lua-utils.nvim",
			"pysan3/pathlib.nvim",
			"nvim-neotest/nvim-nio",
		},
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
	},

	-- -- Markdown Preview
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	build = "cd app && yarn install",
	-- 	init = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },

	-- VS Code Tasks
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		--- @type snakcs.config
		opts = {
			picker = {
				enabled = true,
			},
			explorer = {
				enabled = true,
				replace_netrw = true,
				trash = true,
			},
		},
	},
	-- {
	-- 	"EthanJWright/vs-tasks.nvim",
	-- 	dependencies = "nvim-lua/popup.nvim",
	-- 	keys = {
	-- 		{ "<leader>'", ":lua require('telescope').extensions.vstask.tasks()<CR>", desc = "VS Code Tasks" },
	-- 	},
	-- },

	-- Autotag for JSX/TSX
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		},
	},
	-- Chezmoi syntax highlighting
	{
		"alker0/chezmoi.vim",
		init = function()
			-- This setting is required for proper filetype detection in Neovim
			vim.g["chezmoi#use_tmp_buffer"] = 1
		end,
	},

	-- Chezmoi dotfiles management
	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({
				-- your configurations
			})
		end,
	},

	-- Database UI
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
}
