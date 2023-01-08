local vim = vim
-- How to Lsp details
-- LspINfo
-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
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
nkeymap('gr', ':Telescope lsp_references<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('ge', ':lua vim.lsp.diagnostic.goto_next()<cr>')
nkeymap('gE', ':lua vim.lsp.diagnostic.goto_prev()<cr>')
nkeymap('<M-w>', ':Telescope diagnostics<cr>')
nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<space>k>', ':lua vim.lsp.buf.signature_help()<cr>')
nkeymap('<M-space>', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<leader>a', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

local nvim_lsp = require'lspconfig'
local root_pattern = nvim_lsp.util.root_pattern

-----------------------
-- SQL
-----------------------
nvim_lsp.sqls.setup{
    on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
    end
}
-----------------------
-- JAVA
-----------------------
-- require'lspconfig'.jdtls.setup{}

-----------------------
-- AWK
-----------------------

nvim_lsp.awk_ls.setup{}

-----------------------
-- BASH
-----------------------

-- require'lspconfig'.bash_ls.setup{}
--
-----------------------
-- HASKELL
-----------------------

-- nvim_lsp.hls.setup{
--     filetypes = { 'haskell', 'lhaskell', 'cabal' },
--     single_file_suppor = true,
-- }

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
require("clangd_extensions").setup {
  server = {
      capabilities = capabilities
      -- options to pass to nvim-lspconfig
      -- i.e. the arguments to require("lspconfig").clangd.setup({})
  },
  extensions = {
      -- defaults:
      -- Automatically set inlay hints (type hints)
      autoSetHints = true,
      -- These apply to the default ClangdSetInlayHints command
      inlay_hints = {
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refersh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause  higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = "CursorHold",
          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,
          -- prefix for parameter hints
          parameter_hints_prefix = "<- ",
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- The color of the hints
          highlight = "Comment",
          -- The highlight group priority for extmark
          priority = 100,
      },
      ast = {
          role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
          },

          kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
          },

          highlights = {
              detail = "Comment",
          },
      memory_usage = {
          border = "none",
      },
      symbol_info = {
          border = "none",
      },
    }
  },
};
-----------------------
-- lua
-----------------------
nvim_lsp.sumneko_lua.setup({
  cmd = {"lua-language-server"};
  capabilities = capabilities;
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT'},
      diagnostics = {
        enable = true,
        globals = {"vim", "describe", "it", "before_each", "after_each"}
      },
      workspace = {
        maxPreload = 10000,
        preloadFileSize = 1000,
        checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
})
-----------------------
-- Ruby
-----------------------
-- require'lspconfig'.sorbet.setup{
--   cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--disable-watchman"}
-- }

-- require'lspconfig'.steep.setup{}

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

