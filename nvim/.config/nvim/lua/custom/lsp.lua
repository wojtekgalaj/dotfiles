local lspconfig = require "lspconfig"
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- bail if this is obsidian insert mode
if vim.g.obsidian then
  return
end

-- → svelte.ask-to-enable-ts-plugin                                 default: true
-- → svelte.enable-ts-plugin                                        default: false
local servers = {
  pyright = true,
  rescriptls = true,
  vacuum = true,
  dockerls = true,
  jinja_lsp = true,
  denols = {
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    single_file_support = false,
    settings = {
      enable = true,
      lint = true,
      unstable = true,
      enableTsPlugin = true,
    },
  },
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
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "svelte",
      "jinja",
    },
  },
  graphql = true,
  gitlab_ci_ls = true,
  terraformls = true,
  intelephense = true,
  clangd = true,
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
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
  }, config)

  lspconfig[name].setup(config)
end

-- Lua Setup
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- I am pretty sure that this this repeated.
for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup {
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
  }
end

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
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 }, { desc = "Go to [t]ype definition" })
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

require("lspconfig").gdscript.setup(capabilities)

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

require("typescript-tools").setup {
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "tsconfig.dev.json"),
  single_file_support = false,
  lspconfig = {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
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
      local params = vim.lsp.util.make_position_params(0, "utf-16")
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

-- local is_godot_project = vim.fn.getcwd() .. "/project.godot"
-- print(is_godot_project)
--
-- if is_godot_project then
--   vim.fn.serverstart "~/.config/godothost"
-- end
