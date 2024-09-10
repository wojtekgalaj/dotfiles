local set = vim.keymap.set

set("n", "<Left>", "<c-w>5<")
set("n", "<Right>", "<c-w>5>")
set("n", "<Up>", "<C-W>+")
set("n", "<Down>", "<C-W>-")

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Esc when I don't have my keyboard
set("i", "jk", "<Esc>")

set("n", "<esc>", "<cmd>noh<cr>")

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

vim.api.nvim_set_keymap("i", "<C-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<C-\\><C-N><C-w>l", { noremap = true })

-- TODO: This is not the right place for this. Find a better one.
local nvim_tmux_nav = require "nvim-tmux-navigation"
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

local which_key = require "which-key"
local builtin = require "telescope.builtin"
local notify = require("telescope").extensions.notify

vim.g.miniindentscope_disable = true
local toggle_indentscope_for_buffer = function()
  vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
end

which_key.add {
  { "g", group = "[G]o to..." },
  { "gd", vim.lsp.buf.definition, desc = "[D]efinition" },
  { "gk", vim.lsp.buf.declaration, desc = "de[K]laration" },
  { "gr", builtin.lsp_references, desc = "[R]eferences" },
  { "gi", vim.lsp.buf.implementation, desc = "[I]mplementation" },
  { "gt", vim.lsp.buf.type_definition, desc = "[T]ype definition" },
  { "gs", group = "[S]ymbols..." },
  { "gsd", builtin.lsp_document_symbols, desc = "[D]ocument symbols" },
  { "gsw", builtin.lsp_workspace_symbols, desc = "[W]orkspace symbols" },
  { "q", group = "[Q]uit" },
  { "<leader>", group = "Misc" },
  { "<leader><space>", builtin.find_files, desc = "[SPACE] List files in project" },
  { "<leader>z", "<cmd>:tabnew %<cr>", desc = "[Z]oom current buffer" },
  { "<leader>x", group = "[X]ecute" },
  { "<leader>xl", "<cmd>.lua<cr>", desc = "[L]ine" },
  { "<leader>xf", "<cmd>source %<cr>", desc = "[F]ile" },
  { "<leader>xh", group = "[H]url" },
  { "<leader>xhA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
  { "<leader>xha", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
  { "<leader>xhe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
  { "<leader>xhm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
  { "<leader>xhs", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
  -- Run Hurl request in visual mode
  { "<leader>xhv", ":HurlRunner<CR>", desc = "Run Visual", mode = "v" },
  { "<leader>b", group = "[B]uffer" },
  { "<leader>bd", "<cmd>bdel<cr>", desc = "[D]elete" },
  { "<leader>bc", "<cmd>VenterToggle<cr>", desc = "[C]enter" },
  { "<leader>j", "<cmd>wa<cr>", desc = "[J]ust save all" },
  { "<leader>f", "<cmd>cclose<cr>", desc = "Close Quick[F]ix" },
  { "<leader>q", "<cmd>q<cr>", desc = "[!]uit" },
  { "<leader>e", vim.diagnostic.open_float, desc = "[E]rrors" },
  { "<leader>g", group = "[G]it" },
  { "<leader>gv", "<cmd>Neogit<cr>", desc = "[V]ersion control" },
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "[B]lame" },
  { "<leader>gc", group = "[C]ommits" },
  { "<leader>gca", builtin.git_commits, desc = "[A]ll" },
  { "<leader>gcb", builtin.git_bcommits, desc = "[B]uffer" },
  { "<leader>gh", group = "[H]istory" },
  { "<leader>ghe", "<cmd>DiffviewFileHistory<cr>", desc = "[E]verything" },
  { "<leader>ghb", "<cmd>DiffviewFileHistory %<cr>", desc = "[B]uffer" },
  { "<leader>l", group = "[L]sp" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "[R]ename" },
  { "<leader>ll", "<cmd>LspRestart<cr>", desc = "[L]estart" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = "[H]elp" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code [A]ction" },
  { "<leader>s", group = "[S]earch" },
  { "<leader>sg", builtin.live_grep, desc = "[G]rep project" },
  { "<leader>ss", builtin.current_buffer_fuzzy_find, desc = "[S]tring in buffer" },
  { "<leader>sj", builtin.jumplist, desc = "[J]umplist" },
  { "<leader>sn", notify.notify, desc = "[N]otifications" },
  { "<leader>sr", builtin.resume, desc = "[R]esume last" },
  { "<leader>sb", builtin.buffers, desc = "[B]uffers" },
  { "<leader>su", builtin.grep_string, desc = "thing [U]nder cursor" },
  { "<leader>t", group = "[T]oggle" },
  { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "[T]oggle" },
  { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[B]uffer" },
  { "<leader>tf", "<cmd>Trouble qflist toggle<cr>", desc = "[F]ix" },
  { "<leader>ti", toggle_indentscope_for_buffer, desc = "mini[I]ndent for buffer" },
  { "<leader>tr", "<cmd>ReplToggle<cr>", desc = "[R]epl" },
  { "<leader>u", group = "[U]nit Tests" },
  { "<leader>ur", "<cmd>Neotest run<cr>", desc = "[R]un" },
  { "<leader>us", "<cmd>Neotest summary<cr>", desc = "[S]ummary" },
  { "<leader>uu", "<cmd>Neotest output<cr>", desc = "o[U]tput" },
}
