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

	-- Jump around, jump around, jump up, jump up and get down
	use("justinmk/vim-sneak") -- Sneak around with s and S

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
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"zbirenbaum/copilot-cmp",
		},
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

	use("EdenEast/nightfox.nvim")

	use("mattn/emmet-vim") -- Emmet support

	use("nvim-lualine/lualine.nvim") -- Fancier statusline

	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("christoomey/vim-tmux-navigator")

	-- Which key. I need to work on this setup.
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
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

	-- Use HTML syntax highlighting for webc files
	vim.cmd([[
	    augroup webc_ft
	      au!
	      autocmd BufNewFile,BufRead *.webc   set syntax=html
	    augroup END
	  ]])

	-- AI Plugins

	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup()
		end,
	})

	use({
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	-- Quick navigation in the buffer

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

	dap.configurations.typescript = {
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

	-- Pico8
	use("bakudankun/pico-8.vim")

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
