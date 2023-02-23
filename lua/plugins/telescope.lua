return {
  {
    "nvim-telescope/telescope.nvim",
    -- lazy = false,
    event = "VeryLazy",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "romgrk/fzy-lua-native",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-arecibo.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
        },
      },
    },
    config = function(_, _)
      local opts = {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-i>"] = function()
                neovim.telescope("find_files", { no_ignore = true })()
              end,
              ["<a-h>"] = function()
                neovim.telescope("find_files", { hidden = true })()
              end,
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-j>"] = function(...)
                return require("telescope.actions").move_selection_better(...)
              end,
              ["<C-k>"] = function(...)
                return require("telescope.actions").move_selection_previous(...)
              end,
              ["<Esc>"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
        pickers = {
          lsp_code_actions = {
            theme = "dropdown",
          },
          code_action = {
            theme = "cursor",
          },
          lsp_workspace_diagnostics = {
            theme = "dropdown",
          },
          rename = {
            theme = "cursor",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
          },
        },
      }
      require("telescope").setup(opts)
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("frecency")
      require("telescope").load_extension("arecibo")
    end,
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      {
        "/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({}))
        end,
        desc = "Find in Files (Grep)",
      },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", neovim.telescope("files"), desc = "Find Files (root dir)" },
      { "<C-f>", neovim.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", neovim.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", neovim.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sf", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Command History" },
      { "<leader>sg", neovim.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", neovim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sw", neovim.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>sW", neovim.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>uC", neovim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        neovim.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
    },
  },
}
