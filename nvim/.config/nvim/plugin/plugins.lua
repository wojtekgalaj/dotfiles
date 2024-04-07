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

	use("nvim-lua/plenary.nvim")

	-- Jump around, jump around, jump up, jump up and get down
	use("justinmk/vim-sneak") -- Sneak around with s and S

	use("nvim-treesitter/nvim-treesitter-context")

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

	-- Colorschemes
	use("EdenEast/nightfox.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })

	use("mattn/emmet-vim") -- Emmet support

	use("nvim-lualine/lualine.nvim") -- Fancier statusline

	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("christoomey/vim-tmux-navigator")

	use("jmckiern/vim-venter")

	-- Which key. I need to work on this setup.
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	})

	use({
		"folke/noice.nvim",
		requires = { "MunifTanjim/nui.nvim" },
	})

	require("noice").setup({
		icons = {
			error = "",
			warning = "",
			info = "",
			hint = "",
			ok = "",
		},
	})

	use("rcarriga/nvim-notify")

	-- Prettier and styling plugins
	use("sbdchd/neoformat")

	local prettierrc_exists = io.open(vim.fn.findfile(".prettierrc", ".;"))
	local prettierrc_json_exists = io.open(vim.fn.findfile(".prettierrc.json", ".;"))

	if prettierrc_exists or prettierrc_json_exists then
		vim.cmd([[
	    autocmd BufWritePre *.js Neoformat prettier
	    autocmd BufWritePre *.jsx Neoformat prettier
	    autocmd BufWritePre *.ts Neoformat prettier
	    autocmd BufWritePre *.tsx Neoformat prettier
	    autocmd BufWritePre *.svelte Neoformat prettier
	  ]])
	end
	vim.cmd([[
	    autocmd BufWritePre *.lua Neoformat stylua
	    autocmd BufWritePre *.go Neoformat gofmt
	  ]])

	-- This one is used in kickstart. I should have a look at it sometime.
	-- For now though, Neoformat is fine.
	--
	-- require("packer").startup(function()
	-- 	use({
	-- 		"stevearc/conform.nvim",
	-- 		config = function()
	-- 			require("conform").setup({
	-- 				javascript = {
	-- 					{ "prettierd", "prettier" },
	-- 				},
	-- 			})
	-- 		end,
	-- 	})
	-- end)

	use("Glench/Vim-Jinja2-Syntax")

	-- Use HTML syntax highlighting for webc files
	vim.cmd([[
	    augroup webc_ft
	      au!
	      autocmd BufNewFile,BufRead *.webc   set syntax=html
	    augroup END
	  ]])

	-- AI Plugins

	use({ "sourcegraph/sg.nvim", run = "nvim -l build/init.lua" })
	-- use({
	-- 	"jackMort/ChatGPT.nvim",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			api_key_command = "",
	-- 		})
	-- 	end,
	-- 	requires = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- })
	-- Quick navigation in the buffer

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Debugger stuff
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-ui",
		},
	})

	-- Syntax
	use("othree/html5.vim")
	use("pangloss/vim-javascript")
	use("evanleck/vim-svelte")
	use("mustache/vim-mustache-handlebars")
	use("jparise/vim-graphql")

	-- Pico8
	use("bakudankun/pico-8.vim")

	-- Typescript helpers
	use("marilari88/twoslash-queries.nvim")

	-- REST Client
	use({ "rest-nvim/rest.nvim", requires = { "nvim-lua/plenary.nvim" } })

	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
	})
	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

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
