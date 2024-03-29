-- This file contains all the remaps
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_cursor = 0
vim.g.netrw_dirhistmax = 0

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>w", "<cmd>wa<cr>", { silent = true })

-- I'll add j as save all, this is what I have been using for years now in emacs.
vim.keymap.set("n", "<leader>j", "<cmd>wa<cr>", { silent = true, desc = "[J]ust save all" })

vim.keymap.set("n", "<leader>x", "<cmd>Ex<cr>", { silent = true, desc = "[E]xplorer" })

vim.keymap.set("n", "<leader>bd", "<cmd>bdel<cr>", { silent = true, noremap = true, desc = "[B]uffer [D]elete" })

vim.keymap.set("n", "<leader>v", "<cmd>Neogit<cr>", { silent = true, noremap = true, desc = "[V]ersion control" })

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = true, noremap = true, desc = "[Q]uit" })

-- Use Ctrl + hjkl to navigate splits
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true, noremap = true, desc = "[E]rrors" })

vim.keymap.set("n", "<leader>f", "<cmd>cclose<cr>", { silent = true, noremap = true, desc = "Close Quick[F]ix" })

-- Clear highlight with ESC
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true, desc = "Clear highlight" })
