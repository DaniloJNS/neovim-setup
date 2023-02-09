return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lib.util").has("nvim-cmp")
        end,
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- Automatically format on save
      autoformat = false,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overriden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        sumneko_lua = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      require("plugins.lsp.format").autoformat = opts.autoformat
      -- setup formatting and keymaps
      require("lib.util").on_attach(function(client, buffer)
        -- require("plugins.lsp.format").on_attach(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "ray-x/guihua.lua",
    event = "VeryLazy",
    build = function()
      vim.fn.system("cd lua/fzy && make")
    end,
  },
  {
    "ray-x/navigator.lua",
    event = "BufReadPre",
    config = function()
      require("navigator").setup({
        lsp = {
          format_on_save = {
            enable = { "lua", "go", "c", "javascript" },
            disable = { "ruby" },
          },
          document_highlight = false,
        },
        default_mapping = false,
        keymaps = {
          { key = "gr", func = require("navigator.reference").async_ref, desc = "async_ref" },
          { key = "<Leader>gr", func = require("navigator.reference").reference, desc = "reference" }, -- reference deprecated
          { mode = "i", key = "<M-k>", func = vim.lsp.signature_help, desc = "signature_help" },
          { key = "gk", func = vim.lsp.buf.signature_help, desc = "signature_help" },
          { key = "g0", func = require("navigator.symbols").document_symbols, desc = "document_symbols" },
          { key = "gW", func = require("navigator.workspace").workspace_symbol_live, desc = "workspace_symbol_live" },
          { key = "<c-]>", func = require("navigator.definition").definition, desc = "definition" },
          { key = "gd", func = require("navigator.definition").definition, desc = "definition" },
          { key = "gD", func = vim.lsp.buf.declaration, desc = "declaration" },
          { key = "gp", func = require("navigator.definition").definition_preview, desc = "definition_preview" },
          { key = "<Leader>gt", func = require("navigator.treesitter").buf_ts, desc = "buf_ts" },
          { key = "<Leader>gT", func = require("navigator.treesitter").bufs_ts, desc = "bufs_ts" },
          { key = "<Leader>ct", func = require("navigator.ctags").ctags, desc = "ctags" },
          { key = "<Space>ca", mode = "n", func = require("navigator.codeAction").code_action, desc = "code_action" },
          {
            key = "<Space>ca",
            mode = "v",
            func = require("navigator.codeAction").range_code_action,
            desc = "range_code_action",
          },
          -- { key = '<Leader>re', func = 'rename()' },
          { key = "<Space>rn", func = require("navigator.rename").rename, desc = "rename" },
          { key = "<Leader>gi", func = vim.lsp.buf.incoming_calls, desc = "incoming_calls" },
          { key = "<Leader>go", func = vim.lsp.buf.outgoing_calls, desc = "outgoing_calls" },
          { key = "gi", func = vim.lsp.buf.implementation, desc = "implementation" },
          { key = "<Space>D", func = vim.lsp.buf.type_definition, desc = "type_definition" },
          { key = "gL", func = require("navigator.diagnostics").show_diagnostics, desc = "show_diagnostics" },
          { key = "gG", func = require("navigator.diagnostics").show_buf_diagnostics, desc = "show_buf_diagnostics" },
          {
            key = "<Leader>dt",
            func = require("navigator.diagnostics").toggle_diagnostics,
            desc = "toggle_diagnostics",
          },
          { key = "]d", func = vim.diagnostic.goto_next, desc = "next diagnostics" },
          { key = "[d", func = vim.diagnostic.goto_prev, desc = "prev diagnostics" },
          { key = "]O", func = vim.diagnostic.set_loclist, desc = "diagnostics set loclist" },
          { key = "]r", func = require("navigator.treesitter").goto_next_usage, desc = "goto_next_usage" },
          { key = "[r", func = require("navigator.treesitter").goto_previous_usage, desc = "goto_previous_usage" },
          { key = "<C-LeftMouse>", func = vim.lsp.buf.definition, desc = "definition" },
          { key = "g<LeftMouse>", func = vim.lsp.buf.implementation, desc = "implementation" },
          { key = "<Leader>k", func = require("navigator.dochighlight").hi_symbol, desc = "hi_symbol" },
          {
            key = "<Space>wa",
            func = require("navigator.workspace").add_workspace_folder,
            desc = "add_workspace_folder",
          },
          {
            key = "<Space>wr",
            func = require("navigator.workspace").remove_workspace_folder,
            desc = "remove_workspace_folder",
          },
          { key = "<Space>ff", func = vim.lsp.buf.format, mode = "n", desc = "format" },
          { key = "<Space>ff", func = vim.lsp.buf.range_formatting, mode = "v", desc = "range format" },
          {
            key = "<Space>gm",
            func = require("navigator.formatting").range_format,
            mode = "n",
            desc = "range format operator e.g gmip",
          },
          {
            key = "<Space>wl",
            func = require("navigator.workspace").list_workspace_folders,
            desc = "list_workspace_folders",
          },
          {
            key = "<Space>la",
            mode = "n",
            func = require("navigator.codelens").run_action,
            desc = "run code lens action",
          },
        },
        icons = {
          icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
          -- Code action
          code_action_icon = "🏏", -- "",
          -- code lens
          code_lens_action_icon = "👓",
          -- Diagnostics
          diagnostic_head = "🐛",
          diagnostic_err = "📛",
          diagnostic_warn = "👎",
          diagnostic_info = [[👩]],
          diagnostic_hint = [[💁]],

          diagnostic_head_severity_1 = "🈲",
          diagnostic_head_severity_2 = "☣️",
          diagnostic_head_severity_3 = "👎",
          diagnostic_head_description = "👹",
          diagnostic_virtual_text = "💬",
          diagnostic_file = "🚑",
          -- Values
          value_changed = "📝",
          value_definition = "🐶🍡", -- it is easier to see than 🦕
          side_panel = {
            section_separator = "",
            line_num_left = "",
            line_num_right = "",
            inner_node = "├○",
            outer_node = "╰○",
            bracket_left = "⟪",
            bracket_right = "⟫",
          },
          -- Treesitter
          match_kinds = {
            var = " ", -- "👹", -- Vampaire
            method = "ƒ ", --  "🍔", -- mac
            ["function"] = " ", -- "🤣", -- Fun
            parameter = "  ", -- Pi
            associated = "🤝",
            namespace = "🚀",
            type = " ",
            field = "🏈",
            module = "📦",
            flag = "🎏",
          },
          treesitter_defult = "🌲",
          doc_symbols = "",
        },
        mason = true,
      })
    end,
  },
  {
    event = "BufReadPre",
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
    keys = {
      {
        "<leader>cst",
        function()
          require("lsp_signature").toggle_float_win()
        end,
        desc = "Toggle signature ui",
      },
    },
  },
}
