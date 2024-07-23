require("mason").setup()

local servers = {
  "lua_ls",
  "pyright",
  "gopls",
  "svelte",
  "tailwindcss",
  "eslint",
  "yamlls",
  "cssls",
  "emmet_language_server",
  "custom_elements_ls",
  "graphql",
  "gitlab_ci_ls",
  "jsonls",
  "yamlls",
}

require("mason-tool-installer").setup {
  ensure_installed = servers,
}

-- Setup for diagnostics UI. I don't like virtual text or the underlines.
-- A mark in the gutter is cleaner and quite sufficient.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = false,
  underline = false,
  update_in_insert = false,
  virtual_text = false,
})

-- Lua Setup
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup {
    capabilities = capabilities,
  }
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover LSP docs" })
  end,
})

local config = require "lspconfig"

config.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

config.gitlab_ci_ls.setup {}

config.pyright.setup {}

config.jsonls.setup {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

config.yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}

config.gopls.setup {}
config.cssls.setup {}
config.custom_elements_ls.setup {}
config.tailwindcss.setup {}
