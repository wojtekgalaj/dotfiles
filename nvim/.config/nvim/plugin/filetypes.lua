vim.filetype.add {
  extension = {
    ["njk"] = "jinja",
    ["svx"] = "markdown",
  },
  pattern = {
    ["deno.{json,jsonc,lock}"] = "deno.typescript",
    ["*.gitlab-ci*.{yml,yaml}"] = "yaml.gitlab",
  },
}
-- --- Holds a collection of filetype patterns and filetypes that should be set for each of them.
-- --- @type table<number, {pattern: string, filetype: string}>
-- local pattern_type_table = {
--   {
--     pattern = "*.gitlab-ci*.{yml,yaml}",
--     filetype = "yaml.gitlab",
--   },
--   {
--     pattern = "deno.json",
--     filetype = "deno.typescript",
--   },
--   {
--     pattern = "rc$",
--     filetype = "bash",
--   },
--   {
--     pattern = "*.njk",
--     filetype = "jinja",
--   },
-- }
--
-- --- Helper function to check if a file path matches a pattern
-- --- @param path string The file path to check
-- --- @param pattern string The pattern to check against
-- ---
-- local function match_pattern(path, pattern)
--   local match = string.match(path, pattern)
--   return match ~= nil
-- end
--
-- --- Function to find the filetype for a given file path
-- --- @param path string The file path to check
-- --- @return string|nil The filetype to set
-- ---
-- local function find_filetype_for_pattern(path)
--   for _, entry in ipairs(pattern_type_table) do
--     if match_pattern(path, entry.pattern) then
--       return entry.filetype
--     end
--   end
--   return nil -- No match found
-- end
--
-- -- Set the filetype based on a regular expression match on the file path
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   callback = function()
--     local path = vim.fn.expand "%:p"
--     print(path)
--     local filetype = find_filetype_for_pattern(path)
--     if filetype then
--       vim.bo.filetype = filetype
--     end
--   end,
-- })
