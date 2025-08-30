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
			-- in your Lazy plugin spec list
			{
				"nvim-tree/nvim-web-devicons",
				lazy = true,
				opts = {
					-- your personal icons can go here (to override)
					override = {
						zsh = {
							icon = "",
							color = "#428850",
							cterm_color = "65",
							name = "Zsh",
						},
					},

					-- globally enable different highlight colors per icon (default true)
					color_icons = true,

					-- globally enable default icons (default false)
					default = true,

					-- enable "strict" selection of icons
					strict = true,

					-- set light/dark variant manually (nil uses background)
					variant = nil, -- or "light" / "dark"

					-- override icons by filename
					override_by_filename = {
						[".gitignore"] = {
							icon = "",
							color = "#f1502f",
							name = "Gitignore",
						},
					},

					-- override icons by extension
					override_by_extension = {
						["log"] = {
							icon = "",
							color = "#81e043",
							name = "Log",
						},
					},

					-- override icons by operating system
					override_by_operating_system = {
						["apple"] = {
							icon = "",
							color = "#A2AAAD",
							cterm_color = "248",
							name = "Apple",
						},
					},
				},
			},
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

			-- Telescope keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			-- Additional telescope keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })

			-- Buffer fuzzy search
			vim.keymap.set("n", "<leader>f", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[b] Fuzzily search in current buffer" })

			-- Search in open files
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Search Neovim config files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup()
		end,
	},

	-- File Explorer (NvimTree)
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = false,
			},
			filters = {
				dotfiles = false,
			},
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "[E]xplorer" },
		},
	},

	-- UndoTree
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "[U]ndo tree" },
		},
	},

	-- Global Note
	{
		"backdround/global-note.nvim",
		opts = {},
		keys = {
			{ "<leader>n", "<cmd>GlobalNote<CR>", desc = "[N]otes" },
		},
	},

	-- Comment plugin
	{
		"numToStr/Comment.nvim",
		opts = {},
		keys = {
			{
				"<leader>/",
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				desc = "Toggle comment line",
			},
			{
				"<leader>/",
				function()
					local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
					vim.api.nvim_feedkeys(esc, "nx", false)
					require("Comment.api").toggle.linewise(vim.fn.visualmode())
				end,
				mode = "v",
				desc = "Toggle comment selection",
			},
			{
				"<leader>?",
				function()
					require("Comment.api").toggle.blockwise.current()
				end,
				desc = "Toggle block comment",
			},
			{
				"<leader>?",
				function()
					local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
					vim.api.nvim_feedkeys(esc, "nx", false)
					require("Comment.api").toggle.blockwise(vim.fn.visualmode())
				end,
				mode = "v",
				desc = "Toggle block comment selection",
			},
		},
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

	-- Markdown Preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- VS Code Tasks
	{
		"EthanJWright/vs-tasks.nvim",
		dependencies = "nvim-lua/popup.nvim",
		keys = {
			{ "<leader>'", ":lua require('telescope').extensions.vstask.tasks()<CR>", desc = "VS Code Tasks" },
		},
	},

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

	-- Chezmoi dotfiles management
	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
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
