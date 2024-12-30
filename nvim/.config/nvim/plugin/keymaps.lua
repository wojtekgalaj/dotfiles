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
local multigrep = require "private.telescope.multigrep"
vim.g.miniindentscope_disable = true
local toggle_indentscope_for_buffer = function()
  vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
end

which_key.add {
  { "<leader>", group = "[ ]" },
  { "<leader><space>", builtin.find_files, desc = "[ ] List files in project" },
  { "<leader>e", vim.diagnostic.open_float, desc = "show [e]rror under cursor" },
  { "<leader>j", "<cmd>wa<cr>", desc = "[j]ust save all" },
  { "<leader>q", "<cmd>q<cr>", desc = "[q]uit" },
  --
  { "<leader>a", group = "[a]i" },
  { "<leader>aa", "<cmd>Codeium Auth<cr>", desc = "Codeium [a]uth" },
  { "<leader>ac", "<cmd>Codeium Chat<cr>", desc = "Codeium [c]hat" },
  { "<leader>at", "<cmd>Codeium Toggle<cr>", desc = "Codeium [t]oggle, enable/disable" },
  --
  { "<leader>b", group = "[b]uffer" },
  { "<leader>bc", "<cmd>VenterToggle<cr>", desc = "[c]enter" },
  { "<leader>dw", "<cmd>set invwrap<cr>", desc = "Word [w]rap" },
  { "<leader>bi", toggle_indentscope_for_buffer, desc = "mini[i]ndent for buffer" },
  { "<leader>bz", "<cmd>:tabnew %<cr>", desc = "[z]oom current buffer" },
  --
  { "<leader>r", group = "[r]epl" },
  { "<leader>rt", "<cmd>ReplToggle<cr>", desc = "[t]oggle" },
  { "<leader>rc", "<cmd>ReplClear<cr>", desc = "[c]lear" },
  { "<leader>rr", "<cmd>ReplRunCell<cr>", desc = "[r]un cell" },
  { "<leader>rn", "<cmd>ReplNewCell<cr>", desc = "[n]ew cell" },
  { "<leader>ra", "<cmd>ReplSendArgs<cr>", desc = "send [a]rgs" },
  --
  { "<leader>g", group = "[g]it" },
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "[b]lame" },
  { "<leader>gv", "<cmd>Neogit<cr>", desc = "[v]ersion control" },
  { "<leader>gc", group = "[c]ommits" },
  { "<leader>gca", builtin.git_commits, desc = "[a]ll" },
  { "<leader>gcb", builtin.git_bcommits, desc = "[b]uffer" },
  { "<leader>gh", group = "[h]istory" },
  { "<leader>ghb", "<cmd>DiffviewFileHistory %<cr>", desc = "[b]uffer" },
  { "<leader>ghe", "<cmd>DiffviewFileHistory<cr>", desc = "[e]verything" },
  --
  { "<leader>d", group = "[d]iagnostics" },
  { "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[b]uffer toggle" },
  { "<leader>df", "<cmd>Trouble qflist toggle<cr>", desc = "Quick[f]ix toggle" },
  { "<leader>dr", "<cmd>ReplToggle<cr>", desc = "[r]epl" },
  { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "[t]rouble" },
  {
    "<leader>dT",
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    desc = "[T]oggle on/off",
  },
  --
  { "<leader>c", group = "debug [c]ode" },
  {
    "<leader>cb",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "toggle [b]reakpoint",
  },
  {
    "<leader>cx",
    function()
      require("dap").clear_breakpoints()
    end,
    desc = "[x]lear breakpoints",
  },
  {
    "<leader>cc",
    function()
      require("dap").continue()
    end,
    desc = "start or [c]ontinue debug session",
  },
  {
    "<leader>cr",
    function()
      require("dap").restart()
    end,
    desc = "[r]estart debug session",
  },
  {
    "<leader>ct",
    function()
      require("dap").terminate()
    end,
    desc = "[t]erminate debug session",
  },
  {
    "<leader>cl",
    function()
      require("dap").list_breakpoints()
    end,
    desc = "[l]ist breakpoints",
  },
  {
    "<leader>cs",
    function()
      require("dap").step_over()
    end,
    desc = "[s]tep over",
  },
  {
    "<leader>ci",
    function()
      require("dap").step_into()
    end,
    desc = "step [i]nto",
  },

  --
  { "<leader>f", group = "quick[f]ix" },
  { "<leader>fj", "<cmd>cnext<cr>", desc = "next [j]ob" },
  { "<leader>fk", "<cmd>cprex<cr>", desc = "prev [k]ob" },
  { "<leader>fc", "<cmd>cclose<cr>", desc = "[c]lose" },
  --
  { "<leader>l", group = "[l]sp" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code [a]ction" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = "[h]elp" },
  { "<leader>ll", "<cmd>LspRestart<cr>", desc = "[l]estart" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename" },
  --
  { "<leader>s", group = "[s]earch" },
  { "<leader>sg", builtin.live_grep, desc = "[g]rep project" },
  { "<leader>sd", builtin.lsp_document_symbols, desc = "[d]ocument symbols" },
  { "<leader>sm", multigrep.search, desc = "[m]ultigrep" },
  { "<leader>sj", builtin.jumplist, desc = "[j]umplist" },
  -- { "<leader>sn", notify.notify, desc = "[n]otifications" },
  { "<leader>sr", builtin.resume, desc = "[r]esume last" },
  { "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "string in [b]uffer" },
  { "<leader>su", builtin.grep_string, desc = "thing [u]nder cursor" },
  {
    "<leader>sp",
    function()
      builtin.find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
      }
    end,
    desc = "[p]ackages",
  },
  {
    "<leader>sc",
    function()
      builtin.find_files {
        cwd = vim.fn.stdpath "config",
      }
    end,
    desc = "[c]onfig",
  },
  { "<leader>so", "<cmd>Telescope node_modules list<cr>", desc = "n[o]de modules" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp tags" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[k]eymaps" },
  { "<leader>ss", "<cmd>Telescope buffers<cr>", desc = "[s]ee buffers" },

  --
  -- { "<leader>u", group = "[u]nit Tests" },
  -- { "<leader>ur", "<cmd>Neotest run<cr>", desc = "[r]un" },
  -- { "<leader>us", "<cmd>Neotest summary<cr>", desc = "[s]ummary" },
  -- { "<leader>uu", "<cmd>Neotest output<cr>", desc = "o[u]tput" },
  --
  -- { "<leader>x", group = "[x]ecute" },
  -- { "<leader>xc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl exec [c]ell" },
  -- { "<leader>xf", "<cmd>source %<cr>", desc = "[f]ile" },
  -- { "<leader>xh", group = "[h]url" },
  -- { "<leader>xhA", "<cmd>HurlRunner<CR>", desc = "Run [A]ll requests" },
  -- { "<leader>xha", "<cmd>HurlRunnerAt<CR>", desc = "Run [a]pi request" },
  -- { "<leader>xhe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to [e]ntry" },
  -- { "<leader>xhm", "<cmd>HurlToggleMode<CR>", desc = "Hurl [m]ode" },
  -- { "<leader>xhs", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbo[s]e mode" },
  -- { "<leader>xhv", ":HurlRunner<CR>", desc = "Run Visual", mode = "v" },
  -- { "<leader>xl", "<cmd>.lua<cr>", desc = "[l]ine" },
  -- { "<leader>xs", "<cmd>source ../lua/custom/snippets/all.lua<cr>", desc = "Reload [s]nippets" },
  --
  -- { "g", group = "[g]o to..." },
  -- { "gd", vim.lsp.buf.definition, desc = "[d]efinition" },
  -- { "gi", vim.lsp.buf.implementation, desc = "[i]mplementation" },
  -- { "gk", vim.lsp.buf.declaration, desc = "de[k]laration" },
  -- { "gr", builtin.lsp_references, desc = "[r]eferences" },
  -- { "gs", group = "[s]ymbols..." },
  -- { "gsd", builtin.lsp_document_symbols, desc = "[d]ocument symbols" },
  -- { "gsw", builtin.lsp_workspace_symbols, desc = "[w]orkspace symbols" },
  -- { "gt", vim.lsp.buf.type_definition, desc = "[t]ype definition" },
  -- -- These are here just to add a label to a group which actual keybindings are
  -- -- set up in different files.
  -- { "<leader>r", group = "[r]epl" },
}
