local set = vim.keymap.set

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Esc when I don't have my keyboard
set("i", "jk", "<Esc>")

set("n", "<esc>", "<cmd>noh<cr>")

set("n", "<left>", "<c-w>5<")
set("n", "<right>", "<c-w>5>")
set("n", "<up>", "<C-W>+")
set("n", "<down>", "<C-W>-")

local which_key = require "which-key"
local builtin = require "telescope.builtin"
local multigrep = require "private.telescope.multigrep"
local gitsigns = require "gitsigns"

vim.g.miniindentscope_disable = true

local toggle_indentscope_for_buffer = function()
  vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
end

which_key.add {
  { "<leader>", group = "[keymaps]" },
  {
    "<leader><space>",
    function()
      builtin.find_files { hidden = true }
    end,
    desc = "[space] List files in project",
  },
  { "<leader>e", vim.diagnostic.open_float, desc = "show [e]rror under cursor" },
  { "<leader>j", "<cmd>wa<cr>", desc = "[j]ust save all" },
  { "<leader>q", "<cmd>q<cr>", desc = "[q]uit" },
  { "<leader>qq", "<cmd>qa!<cr>", desc = "[qq]uit!" },
  --
  { "<leader>a", group = "[a]i" },
  { "<leader>ac", "<cmd>AvanteChat<cr>", desc = "Avante [c]hat" },
  { "<leader>an", "<cmd>AvanteChatNew<cr>", desc = "Avante [n]ew chat" },
  { "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "Avante [h]istory" },
  { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante [f]ocus" },
  { "<leader>as", "<cmd>AvanteStop<cr>", desc = "Avante [s]top current request" },
  { "<leader>am", "<cmd>AvanteModels<cr>", desc = "Avante [m]odels list" },
  { "<leader>ax", "<cmd>AvanteClear<cr>", desc = "Avante [x]lear chat" },
  -- { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion [c]hat toggle" },
  -- { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion [a]ctions" },
  -- { "<leader>av", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion add [v]isual", mode = "v" },
  --
  { "<leader>b", group = "[b]uffer" },
  { "<leader>bc", "<cmd>VenterToggle<cr>", desc = "[c]enter" },
  { "<leader>bi", toggle_indentscope_for_buffer, desc = "mini[i]ndent for buffer" },
  { "<leader>bo", "<cmd>:tabnew %<cr>", desc = "[o]nly in a new tab" },
  --
  { "<leader>r", group = "[r]epl" },
  { "<leader>rt", "<cmd>ReplToggle<cr>", desc = "[t]oggle" },
  { "<leader>rc", "<cmd>ReplClear<cr>", desc = "[c]lear" },
  { "<leader>rr", "<cmd>ReplRunCell<cr>", desc = "[r]un cell" },
  { "<leader>rn", "<cmd>ReplNewCell<cr>", desc = "[n]ew cell" },
  { "<leader>ra", "<cmd>ReplSendArgs<cr>", desc = "send [a]rgs" },
  --
  { "<leader>g", group = "[g]it" },
  {
    "<leader>gs",
    gitsigns.stage_hunk,
    desc = "[s]tage hunk",
  },
  {
    "<leader>gd",
    gitsigns.diffthis,
    desc = "[d]iff",
  },
  {
    "<leader>gp",
    gitsigns.preview_hunk,
    desc = "[p]review hunk",
  },
  {
    "<leader>gx",
    gitsigns.preview_hunk_inline,
    desc = "show [x]ed lines",
  },
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "[b]lame" },
  { "<leader>gv", "<cmd>Neogit<cr>", desc = "[v]ersion control" },
  { "<leader>gc", group = "[c]ommits" },
  { "<leader>gca", builtin.git_commits, desc = "[a]ll" },
  { "<leader>gcb", builtin.git_bcommits, desc = "[b]uffer" },
  { "<leader>gh", group = "[h]istory" },
  { "<leader>ghb", "<cmd>DiffviewFileHistory %<cr>", desc = "[b]uffer" },
  { "<leader>ghe", "<cmd>DiffviewFileHistory<cr>", desc = "[e]verything" },
  { "<leader>ghq", "<cmd>DiffviewClose<cr>", desc = "[q]uit" },
  { "<leader>ghr", "<cmd>DiffviewRefresh<cr>", desc = "[r]efresh" },
  --
  { "<leader>d", group = "[d]iagnostics with trouble" },
  { "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[b]uffer toggle" },
  { "<leader>df", "<cmd>Trouble qflist toggle<cr>", desc = "Quick[f]ix toggle" },
  { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "[t]rouble" },
  {
    "<leader>dT",
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    desc = "[T]oggle on/off",
  },
  --
  { "<leader>c", group = "[c]ode" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code [a]ction" },
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
  ---
  {
    "<leader>f",
    group = "[f]iletype specific",
    mode = { "n", "v" },
    cond = function()
      return vim.bo.filetype == "hurl"
    end,
    { "<leader>fA", "<cmd>HurlRunner<CR>", desc = "Run [A]ll requests" },
    { "<leader>fa", "<cmd>HurlRunnerAt<CR>", desc = "Run [a]pi request" },
    { "<leader>fe", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to [e]ntry" },
    { "<leader>fm", "<cmd>HurlToggleMode<CR>", desc = "Hurl [m]ode" },
    { "<leader>fs", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbo[s]e mode" },
    { "<leader>fv", ":HurlRunner<CR>", desc = "Run Visual", mode = "v" },
  },
  --
  { "<leader>l", group = "[l]sp" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = "[h]elp" },
  { "<leader>ll", "<cmd>LspRestart<cr>", desc = "[l]estart" },
  { "<leader>ls", "<cmd>LspStop<cr>", desc = "[s]top" },
  { "<leader>lt", "<cmd>LspStop<cr>", desc = "s[t]art" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "[i]nfo" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename" },
  --
  { "<leadej>o", group = "[o]bsidian" },
  { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "quick switchero[o]" },
  { "<leader>oa", "<cmd>ObsidianOpen<cr>", desc = "open in [app]" },
  { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "[s]earch" },
  --
  { "<leader>i", group = "[i]nsert", mode = { "n", "v" } },
  {
    "<leader>ie",
    function()
      require("nvim-emmet").wrap_with_abbreviation()
    end,
    mode = { "n", "v" },
    desc = "[e]mmet surround",
  },
  { "<leader>ii", "<cmd>Nerdy<cr>", desc = "nerd [icon]" },
  --
  { "<leader>s", group = "[s]earch" },
  { "<leader>sg", builtin.live_grep, desc = "[g]rep project" },
  { "<leader>sd", builtin.lsp_document_symbols, desc = "[d]ocument symbols" },
  { "<leader>sr", multigrep.search, desc = "[r]egex" },
  { "<leader>sm", "<cmd>Noice<cr>", desc = "[m]essages" },
  { "<leader>sj", builtin.jumplist, desc = "[j]umplist" },
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
  { "<leader>t", group = "[t]oggle" },
  { "<leader>tw", "<cmd>ToggleWrapMode<cr>", desc = "[w]rap mode" },
  { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "[m]arkdown view" },
  {
    "<leader>tg",
    function()
      local home = vim.fn.getenv "HOME"
      vim.fn.serverstart(home .. "/.config/godothost")
    end,
    desc = "[g]odot server",
  },
  {
    "<leader>tt",
    function()
      local current = vim.diagnostic.config().virtual_lines
      vim.diagnostic.config { virtual_lines = not current }
    end,
    desc = "[t]ypescript lines",
  },
  --
  { "<leader>u", group = "[u]nit Tests" },
  { "<leader>ur", "<cmd>Neotest run<cr>", desc = "[r]un all" },
  {
    "<leader>un",
    function()
      require("neotest").run.run()
    end,
    desc = "run [n]earest",
  },
  {
    "<leader>uf",
    function()
      require("neotest").run.run(vim.fn.expand "%")
    end,
    desc = "run [f]ile",
  },
  { "<leader>us", "<cmd>Neotest summary<cr>", desc = "[s]ummary" },
  { "<leader>uu", "<cmd>Neotest output<cr>", desc = "o[u]tput" },
  --
  { "<leader>x", group = "[x]ecute" },
  { "<leader>xc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl exec [c]ell" },
  { "<leader>xf", "<cmd>source %<cr>", desc = "[f]ile" },
  { "<leader>xl", "<cmd>.lua<cr>", desc = "[l]ine" },
}
