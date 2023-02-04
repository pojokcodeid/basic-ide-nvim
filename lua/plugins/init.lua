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
		-- commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
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
	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"windwp/nvim-autopairs",
		-- commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
		dependencies = "hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			require("config.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		-- commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
		event = "InsertEnter",
		init = function()
			require("config.comment")
		end,
	},
	-- styleing indent
	{
		"lukas-reineke/indent-blankline.nvim",
		-- commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
		event = "BufRead",
		init = function()
			require("config.indentline")
		end,
	},
	{
		"lewis6991/impatient.nvim",
		-- commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
		event = "VeryLazy",
		init = function()
			require("impatient").enable_profile()
		end,
	},
	{
		"hrsh7th/cmp-buffer",
		event = "VeryLazy",
		-- commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
		-- commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21",
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"neovim/nvim-lspconfig",
		-- commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda",
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
		-- commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
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
	{ "jose-elias-alvarez/null-ls.nvim", 
		--commit = "c0c19f32b614b3921e17886c541c13a72748d450", 
		event = "VeryLazy" 
	},
	{ "RRethy/vim-illuminate", 
		--commit = "a2e8476af3f3e993bb0d6477438aad3096512e42", 
		event = "VeryLazy" 
	},
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
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		config = function()
			require("config.dapui")
		end,
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		enabled = vim.fn.has("win32") == 0,
		init = function()
			require("config.mason_dap")
		end,
	},
	-- for auto close tag
	-- config langsung di treesitter
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		init = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- for coloring pairs
	-- config di treesitter
	{ "p00f/nvim-ts-rainbow", event = "BufWinEnter", dependencies = "nvim-treesitter/nvim-treesitter" },
	-- style
	-- dashboard
	{
		"goolord/alpha-nvim",
		commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31",
		event = "BufWinEnter",
		config = function()
			require("config.alpha")
		end,
	},
	-- unutk line info dibawah
	{
		"nvim-lualine/lualine.nvim",
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
		opts = function()
			require("config.lualine")
		end,
	},
	-- for tree exploler
	{
		"kyazdani42/nvim-tree.lua",
		commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
		event = "BufWinEnter",
		cmd = "NvimTreeToggle",
		dependencies = "kyazdani42/nvim-web-devicons",
		init = function()
			require("config.nvim-tree")
		end,
	},
	-- for file tab
	{
		"akinsho/bufferline.nvim",
		commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
		dependencies = { "kyazdani42/nvim-web-devicons", "famiu/bufdelete.nvim" },
		event = "VeryLazy",
	},
	-- for winbar icon
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("config.breadcrumb")
			require("config.winbar")
		end,
	},
	-- key mappings
	{
		"folke/which-key.nvim",
		event = "BufWinEnter",
		init = function()
			require("config.whichkey")
		end,
	},
	-- for resize screen
	{
		"mrjones2014/smart-splits.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.smartsplit")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		-- commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		cmd = "Telescope",
		init = function()
			require("config.telescope")
		end,
	},
	-- untuk integasi terminal
	{
		"akinsho/toggleterm.nvim",
		-- commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
		cmd = "Toggleterm",
		event = "BufWinEnter",
		init = function()
			require("config.toggleterm")
		end,
	},
	-- for popup alert
	{
		"rcarriga/nvim-notify",
		event = "BufRead",
		config = function()
			local notify = require("notify")
			notify.setup({ background_colour = "#000000" })
			vim.notify = notify.notify
		end,
	},
	-- untuk git
	{
		"lewis6991/gitsigns.nvim",
		-- commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2",
		enabled = vim.fn.executable("git") == 1,
		ft = "gitcommit",
		event = "VeryLazy",
		config = function()
			require("config.gitsigns")
		end,
	},
	-- for popup input
	{
		"stevearc/dressing.nvim",
		event = "BufWinEnter",
		config = function()
			require("config.dressing")
		end,
	},
	--for running code
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
		config = function()
			require("config.coderunner")
		end,
	},
	-- for check startup time
	{ "dstein64/vim-startuptime", cmd = "StartupTime", event = "VeryLazy" },
}
