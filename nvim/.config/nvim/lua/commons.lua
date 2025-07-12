local M = {}

--- check if the `filepath` is in the `target_folder`
--- @param filepath string # Buffer name
--- @param target_folder string # name of the folder to check against
--- @returns boolean
function M.is_in_target_folder(filepath, target_folder)
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
function M.is_in_obsidian_vault(filepath)
  return M.is_in_target_folder(filepath, "wojteks_vault")
end

return M
