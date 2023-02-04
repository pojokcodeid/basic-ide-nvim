return {
	-- core plugins
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	-- color scheme
	{
		"folke/tokyonight.nvim",
		commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("config.tokyonight")
			require("config.colorscheme")
		end,
	},
	-- programming
	-- coloring
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
		run = ":TSUpdate",
		event = "BufWinEnter",
		opts = function()
			require("config.treesitter")
		end,
	},
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
      -- stylua: ignore
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
	},
	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = { "gz" },
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup(opts)
		end,
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
		end,
	},
	{
		"windwp/nvim-autopairs",
		commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		dependencies = "hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			require("config.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
		event = "InsertEnter",
		init = function()
			require("config.comment")
		end,
	},
	-- styleing indent
	{
		"lukas-reineke/indent-blankline.nvim",
		commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
		event = "BufRead",
		init = function()
			require("config.indentline")
		end,
	},
	{
		"lewis6991/impatient.nvim",
		commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
		event = "VeryLazy",
		init = function()
			require("impatient").enable_profile()
		end,
	},
	{
		"hrsh7th/cmp-buffer",
		event = "VeryLazy",
		commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
		commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"neovim/nvim-lspconfig",
		commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda",
		event = "BufWinEnter",
		config = function()
			require("config.lsp")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
	},
	{
		"williamboman/mason.nvim",
		commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
		event = "VeryLazy",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		init = function()
			vim.tbl_map(function(plugin)
				pcall(require, plugin)
			end, { "lspconfig", "null-ls" })
		end,
	},
	-- for formater linter
	{ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450", event = "VeryLazy" },
	{ "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42", event = "VeryLazy" },
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = "jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		opts = function()
			require("config.mason-null-ls")
		end,
	},
	{ "williamboman/nvim-lsp-installer", event = "VeryLazy" },
	-- debuging
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		enabled = vim.fn.has("win32") == 0,
	},
}
