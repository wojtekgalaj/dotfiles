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

--- check if the `filepath` is in the `target_folder`
--- @param filepath string # Buffer name
--- @param target_folder string # name of the folder to check against
--- @returns boolean
local function is_in_target_folder(filepath, target_folder)
  local Path = require "plenary.path"
  local path = Path:new(filepath):parent()
  while path.filename ~= "/" do
    local basename = vim.fn.fnamemodify(path.filename, ":t")
    if path:make_relative "/" == target_folder or basename == target_folder then
      return true
    end
    path = path:parent()
  end
  return false
end

--- check if `filepath` is in my obsidian folder
--- @param filepath string Buffer name
--- @returns boolean
local function is_in_obsidian_vault(filepath)
  return is_in_target_folder(filepath, "wojteks_vault")
end

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.md" },
  callback = function()
    vim.opt_local.wrap = true
    -- check if in the obsidian valut
    -- if yes, disable render markdown
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "" and is_in_obsidian_vault(bufname) then
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
