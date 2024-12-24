return {
  {
    "pappasam/nvim-repl",
    init = function()
      vim.g["repl_filetype_commands"] = {
        javascript = "node",
        svelte = "node",
        lua = "lua",
        typescript = "node",
        typescriptreact = "node",
        go = "go run",
        rust = "cargo run",
        python = "python3",
        sh = "bash",
      }
    end,
  },
}
