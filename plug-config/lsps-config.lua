local vim = vim

-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require'lspconfig'

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

local function nkeymap(key, map)
    keymap('n', key, map, opts)
end

nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('ge', ':lua lua vim.lsp.diagnostic.goto_next()<cr>')
nkeymap('gE', ':lua lua vim.lsp.diagnostic.goto_pre()<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<M-k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<C-space', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<leader>a', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')
-----------------------
-- Dart / Flutter
-----------------------
local function setupFlutterTools()
    require("flutter-tools").setup{} --use defaults
end

pcall(setupFlutterTools)

-----------------------
-- lua
-----------------------
nvim_lsp.sumneko_lua.setup{
    cmd = {"lua-language-server"};
    capabilities = capabilities;
    settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
}

-----------------------
-- Ruby
-----------------------
require'lspconfig'.solargraph.setup{
    cmd = { "solargraph", "stdio" },
    capabilities = capabilities;
    filetypes = { "ruby" },
    init_options = {
      formatting = true
    },
    settings = {
      solargraph = {
        diagnostics = true
      }
    }
}
-----------------------
-- Rust
-----------------------
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
}

capabilities.experimental = {}
capabilities.experimental.hoverActions = true

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
})

local function setup_rust_tools()
    require'rust-tools'.setup({
        autoSetHints = true,
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            show_parameter_hints = true,
        },
    })
    require'rust-tools-debug'.setup()
end

pcall(setup_rust_tools)

-----------------------
-- other random stuff
-----------------------
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
