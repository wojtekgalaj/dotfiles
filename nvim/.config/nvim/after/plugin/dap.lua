local dap_ok, dap = pcall(require, "dap")

if not (dap_ok) then
	print("dap not found, please install it")
	return
end

require('dap').set_log_level('INFO')

dap.adapters.node2 = {
  type = 'executable';
  command = 'node',
  args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' };
}

dap.configurations = {
  javascript = {
    {
      type = 'node2';
      name = 'Launch';
      request = 'launch';
      program = '${file}';
      cwd = vim.fn.getcwd();
      sourceMaps = true;
      protocol = 'inspector';
      console = 'integratedTerminal';
    },
    {
      type = 'node2';
      name = 'Attach';
      request = 'attach';
      program = '${file}';
      cwd = vim.fn.getcwd();
      sourceMaps = true;
      protocol = 'inspector';
      console = 'integratedTerminal';
    }
  }
}


local dap_ui_ok, ui = pcall(require, "dapui")
if not (dap_ok and dap_ui_ok) then
  require("notify")("dap-ui not installed!", "warning")
  return
end
 
ui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        "scopes",
      },
      size = 0.3,
      position = "right"
    },
    {
      elements = {
        "repl",
        "breakpoints"
      },
      size = 0.3,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
})

-- bindings for both plugins
local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")
 
if not (dap_ok and dap_ui_ok) then
  require("notify")("nvim-dap or dap-ui not installed!", "warning") -- nvim-notify is a separate plugin, I recommend it too!
  return
end
 
vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
 
-- Start debugging session
vim.keymap.set("n", "<leader>ds", function()
  dap.continue()
  ui.toggle({})
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)
 
-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover, {silent=true, desc="[D]ap hove[l]}"})
vim.keymap.set("n", "<leader>dc", dap.continue, {silent=true, desc="[D]ap [C]ontinue}"})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {silent=true, desc="[D]ap [B]reakpoint}"})
vim.keymap.set("n", "<leader>dn", dap.step_over, {silent=true, desc="[D]ap step [N]ext}"})
vim.keymap.set("n", "<leader>di", dap.step_into, {silent=true, desc="[D]ap step [I]n}"})
vim.keymap.set("n", "<leader>do", dap.step_out, {silent=true, desc="[D]ap step [O]ut}"})
vim.keymap.set("n", "<leader>dr", function()
  dap.clear_breakpoints()
  require("notify")("Breakpoints cleared", "warn")
end, {silent=true, desc="[D]ap [R]eset"})
 
-- Close debugger and clear breakpoints
vim.keymap.set("n", "<leader>de", function()
  dap.clear_breakpoints()
  ui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
  require("notify")("Debugger session ended", "warn")
end)

