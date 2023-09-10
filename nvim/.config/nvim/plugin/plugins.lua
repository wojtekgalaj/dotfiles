-- This file contains all the plugins
-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- LSP Configuration & Plugins
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	-- Highlight, edit, and navigate code
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	-- Additional text objects via treesitter
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	use({ "NeogitOrg/neogit", requires = "nvim-lua/plenary.nvim" })
	local neogit = require("neogit")
	neogit.setup({})

	use("EdenEast/nightfox.nvim")

	use("nvim-lualine/lualine.nvim") -- Fancier statusline

	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	require("Comment").setup()

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("mattn/emmet-vim")
	use("christoomey/vim-tmux-navigator")

	-- Which key. I need to work on this setup.
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Context plugin
	use("nvim-treesitter/nvim-treesitter-context")

	-- The defaults, here if I want to change them up
	require("treesitter-context").setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	})

	-- Prettier and styling plugins
	use("sbdchd/neoformat")
	use("Glench/Vim-Jinja2-Syntax")
	vim.cmd([[
    autocmd BufWritePre *.js Neoformat prettier
    autocmd BufWritePre *.jsx Neoformat prettier
    autocmd BufWritePre *.ts Neoformat prettier
    autocmd BufWritePre *.tsx Neoformat prettier
    autocmd BufWritePre *.lua Neoformat stylua
    autocmd BufWritePre *.svelte Neoformat prettier
  ]])

	-- Better movement plugins
	use("ggandor/lightspeed.nvim")

	-- Use HTML syntax highlighting for webc files
	vim.cmd([[
    augroup webc_ft
      au!
      autocmd BufNewFile,BufRead *.webc   set syntax=html
    augroup END
  ]])

	-- AI Plugins

	-- use("github/copilot.vim")

	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({ suggestion = { auto_trigger = true } })
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Debugger stuff
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"mfussenegger/nvim-dap-ui",
		},
	})

	-- Require nvim-dap
	local dap = require("dap")

	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode", -- adjust as needed
		name = "lldb",
	}

	local lldb = {
		name = "Launch lldb",
		type = "lldb", -- matches the adapter
		request = "launch", -- could also attach to a currently running process
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	}

	dap.configurations.rust = {
		lldb, -- different debuggers or more configurations can be used here
	}

	-- Configure the node2 debugger
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/.npm-packages/bin/node_modules/vscode-node-debug2/out/src/nodeDebug.js" },
	}

	-- Set the configuration for the debug session
	dap.configurations.javascript = {
		{
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
	}

	-- Start debugging
	vim.api.nvim_set_keymap(
		"n",
		"<leader>dd",
		'<cmd>lua require("dap").continue()<CR>',
		{ noremap = true, silent = true }
	)
	-- Stop debugging
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ds",
		'<cmd>lua require("dap").disconnect()<CR>',
		{ noremap = true, silent = true }
	)
	-- Toggle breakpoint
	vim.api.nvim_set_keymap(
		"n",
		"<leader>db",
		'<cmd>lua require("dap").toggle_breakpoint()<CR>',
		{ noremap = true, silent = true }
	)

	-- Syntax
	use("othree/html5.vim")
	use("pangloss/vim-javascript")
	use("evanleck/vim-svelte")
	use("mustache/vim-mustache-handlebars")
	use("jparise/vim-graphql")

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end
