return {
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup()
    end,
    event = "VeryLazy",
  },
  {
    "mrjones2014/smart-splits.nvim",
    name = "smart-splits",
    config = function()
      require("plugins.config.smart-splits")
    end,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
    },
    cmd = "Neotree",
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = function()
      require("plugins.config.neotree")
    end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>gd"] = { name = "+diffview" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>sn"] = { name = "+noice" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>n"] = { name = "+neogen" },
        ["<C-p>"] = {
          name = "Database",
          u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
          f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
          r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
          q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
        },
      })
    end,
  },
  -- git signs
  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    name = "mini.bufremove",
  },

  -- better diagnosticslist and others
  {
    "folke/trouble.nvim",
    name = 'trouble',
    cmd = { "TroubleToggle", "Trouble" },
    event = "BufReadPost",
    opts = { use_diagnostic_signs = true },
  },

  {
    "folke/todo-comments.nvim",
    name= 'todo-comments',
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    event = "BufReadPost",
    config = true,
  },

  -- Help insert documentation
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
        enabled = true,
        input_after_comment = true,
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function(_, opts)
      function _G.set_terminal_keymaps()
        local op = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], op)
        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], op)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], op)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], op)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], op)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], op)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
      require("toggleterm").setup(opts)
    end,
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-d>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = false,
      shading_factor = "3", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    event = "BufReadPost",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "DaniloJNS/neotest-rspec",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = "container-run-spec.sh",
          }),
        },
      })
    end,
    keys = {
      { "<leader>rc", "<cmd> lua require('neotest').run.run()<cr>", desc = "Run currrent test" },
      { "<leader>rf", "<cmd> lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run currrent file" },
      { "<leader>rl", "<cmd> lua require('neotest').run.last_run()()<cr>", desc = "Run last test" },
      { "<leader>ra", "<cmd> lua require('neotest').run.attach()<cr>", desc = "Attach test" },
      { "<leader>rg", "<cmd> lua require('neotest').run.run(vim.fn.getcwd())<cr>", desc = "Run all tests" },
      { "<leader>ru", "<cmd> lua require('neotest').summary.toggle()<cr>", desc = "Toggle summary" },
      { "<leader>ro", "<cmd> lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle output" },
    },
  },
  {
    "tpope/vim-dadbod",
    event = "VeryLazy",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      local function db_completion()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end

      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾ ",
          buffers = "▾ ",
          saved_queries = "▾ ",
          schemas = "▾ ",
          schema = "▾ פּ",
          tables = "▾ 藺",
          table = "▾ ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ ",
          saved_queries = "▸ ",
          schemas = "▸ ",
          schema = "▸ פּ",
          tables = "▸ 藺",
          table = "▸ ",
        },
        saved_query = "",
        new_query = "璘",
        tables = "離",
        buffers = "﬘",
        add_connection = "",
        connection_ok = "✓",
        connection_error = "✕",
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(db_completion)
        end,
      })
    end,
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup({
        excluded_filetypes = { "toggleterm" },
        cursorline = false,
        signcolumn = false,
        number = false,
      })
    end,
  },
}
