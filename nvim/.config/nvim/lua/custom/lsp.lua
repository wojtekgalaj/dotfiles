local lsp_util = require "vim.lsp.util"
local capabilities = require("blink.cmp").get_lsp_capabilities()
-- bail if this is obsidian insert mode
if vim.g.obsidian then
  return
end

local function deep_extend_force(target, ...)
  for _, source in ipairs { ... } do
    for k, v in pairs(source) do
      if type(v) == "table" and type(target[k]) == "table" then
        deep_extend_force(target[k], v)
      else
        target[k] = v
      end
    end
  end
  return target
end

-- → svelte.ask-to-enable-ts-plugin                                 default: true
-- → svelte.enable-ts-plugin                                        default: false
local servers = {
  -- pyright = true,
  -- rescriptls = true,
  -- vacuum = true,
  dockerls = true,
  jinja_lsp = true,
  bashls = true,
  html = {
    filetypes = { "html" },
  },
  taplo = true,
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
      library = {
        vim.env.VIMRUNTIME,
      },
    },
    diagnostics = {
      disable = "lowercase-global",
      globals = { "vim", "require", "describe", "it", "before_each", "after_each", "love" },
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
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  svelte = {
    settings = {
      svelte = {
        enableTsPlugin = true,
      },
    },
  },
  tailwindcss = true,
  cssls = true,
  emmet_language_server = {
    filetypes = {
      "html",
      "typescriptreact",
      -- "css",
      -- "scss",
      -- "javascript",
      -- "javascriptreact",
      -- "svelte",
      "jinja",
    },
  },
  graphql = true,
  gitlab_ci_ls = true,
  terraformls = true,
  intelephense = true,
  clangd = true,
}

-- Conditionally enable denols if deno.json or deno.jsonc is found
if
  vim.fn.filereadable(vim.fn.getcwd() .. "/deno.json") == 1
  or vim.fn.filereadable(vim.fn.getcwd() .. "/deno.jsonc") == 1
then
  servers.denols = {
    single_file_support = false,
    settings = {
      enable = true,
      lint = true,
      unstable = true,
      enableTsPlugin = true,
    },
  }
end

--- List of keys of the servers table that need to be installed manually
local servers_to_install = {}
for key, value in pairs(servers) do
  if type(value) == "table" then
    if not value.manual_install then
      table.insert(servers_to_install, key)
    end
  else
    if value then
      table.insert(servers_to_install, key)
    end
  end
end

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
  config = deep_extend_force({}, {
    capabilities = capabilities,
  }, config)
  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end

-- Lua Setup
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

--- Disable semantic tokens for these filetypes
local disable_semantic_tokens = { "lua" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local settings = servers[client.name]
    if type(settings) ~= "table" then
      settings = {}
    end

    local builtin = require "telescope.builtin"

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "Go to [d]efinition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0, desc = "Go to [r]eferences" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to [D]eclaration" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to [t]ype definition" })
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

require("lsp_lines").setup()

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
}

vim.keymap.set("", "<leader>le", function()
  local config = vim.diagnostic.config() or {}
  if config.virtual_text then
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
  else
    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
  end
end, { desc = "Toggle lsp_lines" })

if vim.fn.filereadable(vim.fn.getcwd() .. "/tsconfig.json") == 1 then
  require("typescript-tools").setup {
    -- root_dir = function(startpath)
    --   startpath = startpath or vim.fn.getcwd()
    --   local patterns = { "tsconfig.json", "tsconfig.dev.json" }
    --   for _, pattern in ipairs(patterns) do
    --     local found = vim.fs.find(pattern, { path = startpath, upward = true })[1]
    --     if found then
    --       return vim.fs.dirname(found)
    --     end
    --   end
    -- end,
    single_file_support = false,
    lspconfig = {
      capabilities = deep_extend_force(capabilities, {
        textDocument = {
          positionEncodings = { "utf-16" },
        },
      }),
    },
    on_attach = function(client, bufnr)
      -- Force encoding on the client
      client.offset_encoding = "utf-16"

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
      vim.keymap.set("n", "gs", function()
        local ts_utils = require "typescript-tools.api"
        local clients = vim.lsp.get_clients { name = "typescript-tools" }
        if #clients == 0 then
          print "TypeScript LSP not attached"
          return
        end

        -- Use correct arguments for make_position_params
        local params = lsp_util.make_position_params(0, "utf-16")
        print("Position params: " .. vim.inspect(params))

        local _, err = pcall(ts_utils.go_to_source_definition, true)
        if err then
          print(err)
        end
      end, { buffer = bufnr, desc = "Go to source definition" })
    end,
    settings = {
      separate_diagnostic_server = true,
      code_lens = "off",
    },
  }
end

-- local is_godot_project = vim.fn.getcwd() .. "/project.godot"
-- print(is_godot_project)
--
-- if is_godot_project then
--   vim.fn.serverstart "~/.config/godothost"
-- end
