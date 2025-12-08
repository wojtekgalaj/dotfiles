local dap = require "dap"
local ui = require "dapui"

require("dapui").setup()

require("mason-nvim-dap").setup {
  ensure_installed = { "js-debug-adapter" },
  handlers = {},
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug-adapter",
    args = { "${port}" },
  },
}

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      runtimeExecutable = "node",
      runtimeArgs = { "./node_modules/.bin/jest", "--runInBand", "--no-coverage", "--no-cache", "${file}" },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true,
      resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Vitest Tests",
      runtimeExecutable = "node",
      runtimeArgs = { "./node_modules/.bin/vitest", "--run", "${file}" },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true,
      resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
    },
  }
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰓁", texthl = "", linehl = "", numhl = "" })

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
