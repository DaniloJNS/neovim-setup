local vim = vim
-- How to Lsp details
-- LspINfo
-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
nkeymap('ge', ':lua vim.lsp.diagnostic.goto_next()<cr>')
nkeymap('gE', ':lua vim.lsp.diagnostic.goto_prev()<cr>')
nkeymap('<M-w>', ':Telescope diagnostics<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<space>k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<C-space', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<leader>a', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

local nvim_lsp = require'lspconfig'
local root_pattern = nvim_lsp.util.root_pattern
-----------------------
-- JS / TS
-----------------------
local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
nvim_lsp.tsserver.setup {
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    -- set_lsp_config(client)
  end
}

nvim_lsp.efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    -- set_lsp_config(client)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}
-------------------------
-- Dart / Flutter
-----------------------
local function setupFlutterTools()
    require("flutter-tools").setup{} --use defaults
end

pcall(setupFlutterTools)

-----------------------
-- c/c++
-----------------------
nvim_lsp.clangd.setup{
}
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
    root_dir = root_pattern("Gemfile", ".git"),
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
-- Golang
-----------------------
nvim_lsp.gopls.setup{
    cmd = { "gopls" };
    filetypes = { "go", "gomod", "gotmpl" };
    root_dir = root_pattern("go.mod", ".git");
    single_file_support = true;
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
