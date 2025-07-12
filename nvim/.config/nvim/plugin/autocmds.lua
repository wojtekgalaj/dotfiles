-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*" },
  callback = function()
    vim.opt_local.scrolloff = 6
  end,
})

local commons = require "commons"

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.md" },
  callback = function()
    vim.opt_local.wrap = true
    -- check if in the obsidian valut
    -- if yes, disable render markdown
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "" and commons.is_in_obsidian_vault(bufname) then
      require("render-markdown").buf_disable()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.sh", "bash", "*.zsh", "*.fish", "*.ksh", "sketchybarrc" },
  callback = function()
    vim.lsp.start {
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    }
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "gitcommit" },
  callback = function()
    vim.cmd "SmearCursorToggle"
  end,
})
