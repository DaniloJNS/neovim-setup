return {
  -- Better `vim.notify()`
  -- {
  --   "rcarriga/nvim-notify",
  --   keys = {
  --     {
  --       "<leader>un",
  --       function()
  --         require("notify").dismiss({ silent = true, pending = true })
  --       end,
  --       desc = "Delete all Notifications",
  --     },
  --   },
  --   opts = {
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --   },
  -- },

  -- better vim.ui
  -- {
  --   "stevearc/dressing.nvim",
  --   lazy = true,
  --   init = function()
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.select = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.select(...)
  --     end
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.input = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.input(...)
  --     end
  --   end,
  -- },

  -- bufferline
  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       options = {
  --         diagnostics = "nvim_lsp",
  --         always_show_bufferline = false,
  --         diagnostics_indicator = function(_, _, diag)
  --           local icons = require("config").icons.diagnostics
  --           local ret = (diag.error and icons.Error .. diag.error .. " " or "")
  --               .. (diag.warning and icons.Warn .. diag.warning or "")
  --           return vim.trim(ret)
  --         end,
  --         offsets = {
  --           {
  --             filetype = "neo-tree",
  --             text = "File Explorer",
  --             highlight = "Directory",
  --             text_align = "left",
  --           },
  --         },
  --         groups = {
  --           options = {
  --             toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
  --           },
  --           items = {
  --             {
  --               name = "Tests", -- Mandatory
  --               highlight = { underline = true, sp = "blue" }, -- Optional
  --               priority = 2, -- determines where it will appear relative to other groups (Optional)
  --               icon = "", -- Optional
  --               matcher = function(buf) -- Mandatory
  --                 return buf.filename:match("%_test") or buf.filename:match("%_spec")
  --               end,
  --             },
  --             {
  --               name = "Docs",
  --               highlight = { undercurl = true, sp = "green" },
  --               auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
  --               matcher = function(buf)
  --                 return buf.filename:match("%.md") or buf.filename:match("%.txt")
  --               end,
  --               separator = { -- Optional
  --                 style = require("bufferline.groups").separator.tab,
  --               },
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "NTBBloodbath/galaxyline.nvim",
    event = "VeryLazy",
    config = function()
      require("galaxyline.themes.eviline")
    end,
  },
  -- {
  --   "rebelot/heirline.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     -- local conditions = require("heirline.conditions")
  --     -- local utils = require("heirline.utils")
  --     local ViMode = {
  --       init = function(self)
  --         self.mode = vim.fn.mode(1) -- :h mode()
  --
  --         if not self.once then
  --           vim.api.nvim_create_autocmd("ModeChanged", {
  --             pattern = "*:*o",
  --             command = "redrawstatus",
  --           })
  --           self.once = true
  --         end
  --       end,
  --       static = {
  --         mode_names = { -- change the strings if you like it vvvvverbose!
  --           n = "N",
  --           no = "N?",
  --           nov = "N?",
  --           noV = "N?",
  --           ["no\22"] = "N?",
  --           niI = "Ni",
  --           niR = "Nr",
  --           niV = "Nv",
  --           nt = "Nt",
  --           v = "V",
  --           vs = "Vs",
  --           V = "V_",
  --           Vs = "Vs",
  --           ["\22"] = "^V",
  --           ["\22s"] = "^V",
  --           s = "S",
  --           S = "S_",
  --           ["\19"] = "^S",
  --           i = "I",
  --           ic = "Ic",
  --           ix = "Ix",
  --           R = "R",
  --           Rc = "Rc",
  --           Rx = "Rx",
  --           Rv = "Rv",
  --           Rvc = "Rv",
  --           Rvx = "Rv",
  --           c = "C",
  --           cv = "Ex",
  --           r = "...",
  --           rm = "M",
  --           ["r?"] = "?",
  --           ["!"] = "!",
  --           t = "T",
  --         },
  --         mode_colors = {
  --           n = "red",
  --           i = "green",
  --           v = "cyan",
  --           V = "cyan",
  --           ["\22"] = "cyan",
  --           c = "orange",
  --           s = "purple",
  --           S = "purple",
  --           ["\19"] = "purple",
  --           R = "orange",
  --           r = "orange",
  --           ["!"] = "red",
  --           t = "red",
  --         },
  --       },
  --       provider = function(self)
  --         return " %2(" .. self.mode_names[self.mode] .. "%)"
  --       end,
  --       hl = function(self)
  --         local mode = self.mode:sub(1, 1)
  --         return { fg = self.mode_colors[mode], bold = true }
  --       end,
  --       update = {
  --         "ModeChanged",
  --       },
  --     }
  --
  --     return {
  --       statusline = { ViMode },
  --     }
  --   end,
  -- },
  -- statusline
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function(_)
  --     local icons = require("config").icons
  --
  --     local function fg(name)
  --       return function()
  --         local hl = vim.api.nvim_get_hl_by_name(name, true)
  --         return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  --       end
  --     end
  --
  --     return {
  --       options = {
  --         theme = "auto",
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
  --       },
  --       sections = {
  --         lualine_a = { "mode" },
  --         lualine_b = { "branch" },
  --         lualine_c = {
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
  --           -- stylua: ignore
  --           {
  --             function() return require("nvim-navic").get_location() end,
  --             cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
  --           },
  --         },
  --         lualine_x = {
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.command.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --             color = fg("Statement")
  --           },
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.mode.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --             color = fg("Constant"),
  --           },
  --           { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
  --           {
  --             "diff",
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --           },
  --         },
  --         lualine_y = {
  --           { "progress", separator = "", padding = { left = 1, right = 0 } },
  --           { "location", padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return " " .. os.date("%R")
  --           end,
  --         },
  --       },
  --       extensions = { "nvim-tree" },
  --     }
  --   end,
  -- },

  -- indent guides for Neovim
  -- Help indentation
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufReadPost",
  --   opts = {
  --     -- char = "▏",
  --     char = "│",
  --     filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  --     show_trailing_blankline_indent = false,
  --     show_current_context = false,
  --   },
  -- },

  -- active indent guide and indent text objects
  -- {
  --   "echasnovski/mini.indentscope",
  --   version = false, -- wait till new 0.7.0 release to put it back on semver
  --   event = "BufReadPre",
  --   opts = {
  --     -- symbol = "▏",
  --     symbol = "│",
  --     options = { try_as_border = true },
  --   },
  --   config = function(_, opts)
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "terminal" },
  --       callback = function()
  --         vim.b.miniindentscope_disable = true
  --       end,
  --     })
  --     require("mini.indentscope").setup(opts)
  --   end,
  -- },

  -- noicer ui
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --     },
  --   },
  --   -- stylua: ignore
  --   -- keys = {
  --   --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
  --     { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
  --     { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
  --     { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
  --     { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
  --       desc = "Scroll forward" },
  --     { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,
  --       expr = true, desc = "Scroll backward" },
  --   },
  -- },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      vim.b.miniindentscope_disable = true

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- lsp symbol navigation for lualine
  -- {
  --   "SmiteshP/nvim-navic",
  --   lazy = true,
  --   init = function()
  --     vim.g.navic_silence = true
  --     require("lib.util").on_attach(function(client, buffer)
  --       if client.server_capabilities.documentSymbolProvider then
  --         require("nvim-navic").attach(client, buffer)
  --       end
  --     end)
  --   end,
  --   opts = { separator = " ", highlight = true, depth_limit = 5 },
  -- },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  -- { "MunifTanjim/nui.nvim", lazy = true },

  -- scroll bar customizable
  -- {
  --   "petertriho/nvim-scrollbar",
  --   opts = function()
  --     local colors = require("catppuccin.palettes").get_palette("mocha")
  --
  --     return {
  --       handle = {
  --         color = colors.bg_highlight,
  --       },
  --       marks = {
  --         Search = { color = colors.orange },
  --         Error = { color = colors.error },
  --         Warn = { color = colors.warning },
  --         Info = { color = colors.info },
  --         Hint = { color = colors.hint },
  --         Misc = { color = colors.purple },
  --       },
  --       excluded_buftypes = {
  --         "terminal",
  --       },
  --       excluded_filetypes = {
  --         "prompt",
  --         "TelescopePrompt",
  --       },
  --       autocmd = {
  --         render = {
  --           "BufWinEnter",
  --           "TabEnter",
  --           "TermEnter",
  --           "WinEnter",
  --           "CmdwinLeave",
  --           "TextChanged",
  --           "VimResized",
  --           "WinScrolled",
  --         },
  --         clear = {
  --           "BufWinLeave",
  --           "TabLeave",
  --           "TermLeave",
  --           "WinLeave",
  --         },
  --       },
  --       handlers = {
  --         diagnostic = true,
  --         search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
  --       },
  --     }
  --   end,
  --   event = "VeryLazy",
  -- },
}
