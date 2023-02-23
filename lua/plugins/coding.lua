return {

  -- snippets
  -- {
  --   "L3MON4D3/LuaSnip",
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     config = function()
  --
  --       -- require("luasnip").filetype_extend("ruby", { "rails" })
  --     end,
  --   },
  --   opts = {
  --     history = true,
  --     delete_check_events = "TextChanged",
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     -- {
  --     --   "<tab>",
  --     --   function()
  --     --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
  --     --   end,
  --     --   expr = true, silent = true, mode = "i",
  --     -- },
  --     -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
  --     -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  --   },
  -- },
  {
    "SirVer/ultisnips",
    event = "InsertEnter",
    dependencies = {
      "honza/vim-snippets",
    },
    init = function()
      vim.g.UltiSnipsExpandTrigger = "<C-l>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
      vim.g.UltiSnipsEditSplit = "vertical"
      vim.g.UltiSnipsSnippetsDir = "/home/danilo/.config/nvim/UltiSnips"
    end,
    config = function()
      vim.cmd("UltiSnipsAddFiletypes ruby.rails")
    end,
    keys = {
      { "<leader>sp", "<cmd>UltiSnipsEdit<cr>", desc = "Edit snippets" },
    },
  },
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    opts = function()
      local cmp = require("cmp")
      local T = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      return {
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            -- require("luasnip").lsp_expand(args.body)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<TAB>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- elseif require("luasnip").jumpable(1) then
              --   return T("<Plug>(luasnip-expand-or-jump)")
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
              -- elseif require("luasnip").jumpable(-1) then
              --   return T("<Plug>(luasnip-jump-prev)")
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "luasnip" },
          { name = "ultisnips" }, -- For ultisnips users.
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  -- surround
  {
    "echasnovski/mini.surround",
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  -- better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require("mini.ai")
      ai.setup(opts)
    end,
  },
  -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
  {
    event = "BufReadPre",
    "andrewradev/splitjoin.vim",
  },
  -- detect indent style (tabs vs. spaces)
  {
    event = "BufReadPre",
    "tpope/vim-sleuth",
  },
  -- endings for html, xml, etc. - ehances surround
  {
    event = "BufReadPre",
    "tpope/vim-ragtag",
  },
  -- substitute, search, and abbreviate multiple variants of a word
  {
    event = "BufReadPre",
    "tpope/vim-abolish",
  },
  -- context-aware pasting
  {
    "sickill/vim-pasta",
    event = "BufReadPre",
  },
  -- context-aware pasting
  {
    event = "BufReadPre",
    "mg979/vim-visual-multi",
  },
  {
    "gennaro-tedesco/nvim-peekup",
    event = "BufReadPost",
  },
}
