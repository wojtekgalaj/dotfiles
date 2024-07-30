local capabilities = nil
local lspconfig = require "lspconfig"

--- Checks if a file exists in the current directory and its parents
--- @param filename string The name of the file to check. Will be expanded by `vim.fn.expand`
local function find_config_file(filename)
  local expand = vim.fn.expand
  local cwd = expand "%:p:h"
  local root = vim.fn.getcwd()

  while cwd ~= root do
    local path = cwd .. "/" .. filename
    if vim.fn.filereadable(expand(path)) == 1 then
      return true
    end
    cwd = vim.fn.fnamemodify(cwd, ":h")
  end

  -- Check the project root as well
  local root_path = root .. "/" .. filename
  return vim.fn.filereadable(root_path) == 1
end

if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

-- → svelte.ask-to-enable-ts-plugin                                 default: true
-- → svelte.enable-ts-plugin                                        default: false
local servers = {
  pyright = true,
  bashls = true,
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
      checkThirdParty = false,
    },
    telemetry = { enable = false },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        -- schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  svelte = true,
  tailwindcss = true,
  eslint = true,
  cssls = true,
  emmet_language_server = true,
  graphql = true,
  gitlab_ci_ls = true,
}

--- List of keys of the servers table that need to be installed manually
local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

require("mason").setup()

--- These are servers not covered in the servers list
local ensure_installed = {}

vim.list_extend(ensure_installed, servers_to_install)

require("mason-tool-installer").setup {
  ensure_installed = ensure_installed,
}

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

-- Lua Setup
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup {
    capabilities = capabilities,
  }
end

--- Disable semantic tokens for these filetypes
local disable_semantic_tokens = {}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local settings = servers[client.name]
    if type(settings) ~= "table" then
      settings = {}
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end

    -- Override server capabilities
    if settings.server_capabilities then
      for k, v in pairs(settings.server_capabilities) do
        if v == vim.NIL then
          ---@diagnostic disable-next-line: cast-local-type
          v = nil
        end

        client.server_capabilities[k] = v
      end
    end
  end,
})

vim.diagnostic.config { virtual_text = false, update_in_insert = false, underline = false, signs = true }
