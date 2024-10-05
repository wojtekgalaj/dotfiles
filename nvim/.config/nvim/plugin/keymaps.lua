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
  { "<leader>", group = "Commands" },
  { "<leader><space>", builtin.find_files, desc = "[SPACE] List files in project" },
  { "<leader>b", group = "[B]uffer" },
  { "<leader>bc", "<cmd>VenterToggle<cr>", desc = "[C]enter" },
  { "<leader>bd", "<cmd>bdel<cr>", desc = "[D]elete" },
  { "<leader>e", vim.diagnostic.open_float, desc = "[E]rrors" },
  { "<leader>f", "<cmd>cclose<cr>", desc = "Close Quick[F]ix" },
  { "<leader>g", group = "[G]it" },
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "[B]lame" },
  { "<leader>gc", group = "[C]ommits" },
  { "<leader>gca", builtin.git_commits, desc = "[A]ll" },
  { "<leader>gcb", builtin.git_bcommits, desc = "[B]uffer" },
  { "<leader>gh", group = "[H]istory" },
  { "<leader>ghb", "<cmd>DiffviewFileHistory %<cr>", desc = "[B]uffer" },
  { "<leader>ghe", "<cmd>DiffviewFileHistory<cr>", desc = "[E]verything" },
  { "<leader>gs", group = "[S]igns" },
  { "<leader>gv", "<cmd>Neogit<cr>", desc = "[V]ersion control" },
  { "<leader>h", group = "[H]unk" },
  { "<leader>j", "<cmd>wa<cr>", desc = "[J]ust save all" },
  { "<leader>l", group = "[L]sp" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code [A]ction" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = "[H]elp" },
  { "<leader>ll", "<cmd>LspRestart<cr>", desc = "[L]estart" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "[R]ename" },
  { "<leader>q", "<cmd>q<cr>", desc = "[q]uit" },
  { "<leader>s", group = "[S]earch" },
  { "<leader>sb", builtin.buffers, desc = "[b]uffers" },
  { "<leader>sg", builtin.live_grep, desc = "[g]rep project" },
  { "<leader>sj", builtin.jumplist, desc = "[j]umplist" },
  { "<leader>sn", notify.notify, desc = "[n]otifications" },
  { "<leader>sr", builtin.resume, desc = "[r]esume last" },
  { "<leader>ss", builtin.current_buffer_fuzzy_find, desc = "[S]tring in buffer" },
  { "<leader>su", builtin.grep_string, desc = "thing [U]nder cursor" },
  { "<leader>t", group = "Toggle [T]oggle" },
  { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle [B]uffer Trouble" },
  { "<leader>tf", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle Quick[F]ix Trouble" },
  { "<leader>ti", toggle_indentscope_for_buffer, desc = "mini[I]ndent for buffer" },
  { "<leader>tr", "<cmd>ReplToggle<cr>", desc = "Toggle [R]epl" },
  { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle [T]oggle" },
  { "<leader>tw", "<cmd>set invwrap<cr>", desc = "Toggle Word [w]rap" },
  -- lorem ipsum dolorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  { "<leader>u", group = "[U]nit Tests" },
  { "<leader>ur", "<cmd>Neotest run<cr>", desc = "[R]un" },
  { "<leader>us", "<cmd>Neotest summary<cr>", desc = "[S]ummary" },
  { "<leader>uu", "<cmd>Neotest output<cr>", desc = "o[U]tput" },
  { "<leader>x", group = "[X]ecute" },
  { "<leader>xc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl exec [c]ell" },
  { "<leader>xf", "<cmd>source %<cr>", desc = "[F]ile" },
  { "<leader>xh", group = "[H]url" },
  { "<leader>xhA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
  { "<leader>xha", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
  { "<leader>xhe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
  { "<leader>xhm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
  { "<leader>xhs", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
  { "<leader>xhv", ":HurlRunner<CR>", desc = "Run Visual", mode = "v" },
  { "<leader>xl", "<cmd>.lua<cr>", desc = "[L]ine" },
  { "<leader>xs", "<cmd>source ../lua/custom/snippets/all.lua<cr>", desc = "Reload [S]nippets" },
  { "<leader>z", "<cmd>:tabnew %<cr>", desc = "[Z]oom current buffer" },
  { "g", group = "[G]o to..." },
  { "gd", vim.lsp.buf.definition, desc = "[D]efinition" },
  { "gi", vim.lsp.buf.implementation, desc = "[I]mplementation" },
  { "gk", vim.lsp.buf.declaration, desc = "de[K]laration" },
  { "gr", builtin.lsp_references, desc = "[R]eferences" },
  { "gs", group = "[S]ymbols..." },
  { "gsd", builtin.lsp_document_symbols, desc = "[D]ocument symbols" },
  { "gsw", builtin.lsp_workspace_symbols, desc = "[W]orkspace symbols" },
  { "gt", vim.lsp.buf.type_definition, desc = "[T]ype definition" },
  { "q", group = "[Q]uit" },
}
