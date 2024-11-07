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
-- It might be nicer to split these up so the bindings for each plugin live in the same
-- file as the plubin itself.
--
-- The reason to keep it all here is that it makes it easier to see what bindings are taken
-- already. Also, the mappings are not really organised by plugin exactly.
-- Still considering both options.
-- One idea would be to have a file for each group, like "Toggle".
which_key.add {
  { "<leader>", group = "Commands" },
  { "<leader><space>", builtin.find_files, desc = "[ ] List files in project" },
  { "<leader>b", group = "[b]uffer" },
  { "<leader>bc", "<cmd>VenterToggle<cr>", desc = "[c]enter" },
  { "<leader>bd", "<cmd>bdel<cr>", desc = "[d]elete" },
  { "<leader>e", vim.diagnostic.open_float, desc = "show [e]rror under cursor" },
  { "<leader>f", "<cmd>cclose<cr>", desc = "Quick[f]ix" },
  { "<leader>g", group = "[g]it" },
  { "<leader>d", group = "[d]ebug" },
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "[b]lame" },
  { "<leader>gc", group = "[c]ommits" },
  { "<leader>gca", builtin.git_commits, desc = "[a]ll" },
  { "<leader>gcb", builtin.git_bcommits, desc = "[b]uffer" },
  { "<leader>gh", group = "[h]istory" },
  { "<leader>ghb", "<cmd>DiffviewFileHistory %<cr>", desc = "[b]uffer" },
  { "<leader>ghe", "<cmd>DiffviewFileHistory<cr>", desc = "[e]verything" },
  { "<leader>gs", group = "[s]igns" },
  { "<leader>gv", "<cmd>Neogit<cr>", desc = "[v]ersion control" },
  { "<leader>h", group = "[h]unk" },
  { "<leader>j", "<cmd>wa<cr>", desc = "[j]ust save all" },
  { "<leader>l", group = "[l]sp" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code [a]ction" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = "[h]elp" },
  { "<leader>ll", "<cmd>LspRestart<cr>", desc = "[l]estart" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename" },
  { "<leader>q", "<cmd>q<cr>", desc = "[q]uit" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>sb", builtin.buffers, desc = "[b]uffers" },
  { "<leader>sg", builtin.live_grep, desc = "[g]rep project" },
  { "<leader>sj", builtin.jumplist, desc = "[j]umplist" },
  { "<leader>sn", notify.notify, desc = "[n]otifications" },
  { "<leader>sr", builtin.resume, desc = "[r]esume last" },
  { "<leader>ss", builtin.current_buffer_fuzzy_find, desc = "[s]tring in buffer" },
  { "<leader>su", builtin.grep_string, desc = "thing [u]nder cursor" },
  { "<leader>t", group = "[t]oggle" },
  { "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[b]uffer Trouble" },
  { "<leader>tf", "<cmd>Trouble qflist toggle<cr>", desc = "Quick[f]ix Trouble" },
  { "<leader>ti", toggle_indentscope_for_buffer, desc = "mini[i]ndent for buffer" },
  { "<leader>tr", "<cmd>ReplToggle<cr>", desc = "[r]epl" },
  { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "[t]rouble" },
  { "<leader>tw", "<cmd>set invwrap<cr>", desc = "Word [w]rap" },
  -- lorem ipsum dolorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  { "<leader>u", group = "[u]nit Tests" },
  { "<leader>ur", "<cmd>Neotest run<cr>", desc = "[r]un" },
  { "<leader>us", "<cmd>Neotest summary<cr>", desc = "[s]ummary" },
  { "<leader>uu", "<cmd>Neotest output<cr>", desc = "o[u]tput" },
  { "<leader>x", group = "[x]ecute" },
  { "<leader>xc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl exec [c]ell" },
  { "<leader>xf", "<cmd>source %<cr>", desc = "[f]ile" },
  { "<leader>xh", group = "[h]url" },
  { "<leader>xhA", "<cmd>HurlRunner<CR>", desc = "Run [A]ll requests" },
  { "<leader>xha", "<cmd>HurlRunnerAt<CR>", desc = "Run [a]pi request" },
  { "<leader>xhe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to [e]ntry" },
  { "<leader>xhm", "<cmd>HurlToggleMode<CR>", desc = "Hurl [m]ode" },
  { "<leader>xhs", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbo[s]e mode" },
  { "<leader>xhv", ":HurlRunner<CR>", desc = "Run Visual", mode = "v" },
  { "<leader>xl", "<cmd>.lua<cr>", desc = "[l]ine" },
  { "<leader>xs", "<cmd>source ../lua/custom/snippets/all.lua<cr>", desc = "Reload [s]nippets" },
  { "<leader>z", "<cmd>:tabnew %<cr>", desc = "[z]oom current buffer" },
  { "g", group = "[g]o to..." },
  { "gd", vim.lsp.buf.definition, desc = "[d]efinition" },
  { "gi", vim.lsp.buf.implementation, desc = "[i]mplementation" },
  { "gk", vim.lsp.buf.declaration, desc = "de[k]laration" },
  { "gr", builtin.lsp_references, desc = "[r]eferences" },
  { "gs", group = "[s]ymbols..." },
  { "gsd", builtin.lsp_document_symbols, desc = "[d]ocument symbols" },
  { "gsw", builtin.lsp_workspace_symbols, desc = "[w]orkspace symbols" },
  { "gt", vim.lsp.buf.type_definition, desc = "[t]ype definition" },
  -- These are here just to add a label to a group which actual keybindings are
  -- set up in different files.
  { "<leader>r", group = "[r]epl" },
}
