-- This file will contain all the vim opt settings
-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers relative
-- commenting out for now, let's use that jumpy plugin
-- vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Keep some context when scrolling
vim.o.scrolloff = 6

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme catppuccin]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.clipboard = "unnamedplus"

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
