require("navigator").setup({
  lsp = {
    format_on_save = false,
    document_highlight = false,
  },
  default_mapping = false,
  keymaps = {
    -- { key = "<c-]>", func = require("navigator.definition").definition, desc = "definition" },
    -- { key = '<Leader>re', func = 'rename()' },
    -- {
    --   key = "<Leader>dt",
    --   func = require("navigator.diagnostics").toggle_diagnostics,
    --   desc = "toggle_diagnostics",
    -- },
    -- { key = "]r", func = require("navigator.treesitter").goto_next_usage, desc = "goto_next_usage" },
    -- { key = "[r", func = require("navigator.treesitter").goto_previous_usage, desc = "goto_previous_usage" },
    -- { key = "<C-LeftMouse>", func = vim.lsp.buf.definition, desc = "definition" },
    -- { key = "g<LeftMouse>", func = vim.lsp.buf.implementation, desc = "implementation" },
    -- { key = "<Leader>k", func = require("navigator.dochighlight").hi_symbol, desc = "hi_symbol" },
    -- {
    --   key = "<Space>wa",
    --   func = require("navigator.workspace").add_workspace_folder,
    --   desc = "add_workspace_folder",
    -- },
    -- {
    --   key = "<Space>wr",
    --   func = require("navigator.workspace").remove_workspace_folder,
    --   desc = "remove_workspace_folder",
    -- },
    -- {
    --   key = "<Space>gm",
    --   func = require("navigator.formatting").range_format,
    --   mode = "n",
    --   desc = "range format operator e.g gmip",
    -- },
    -- {
    --   key = "<Space>wl",
    --   func = require("navigator.workspace").list_workspace_folders,
    --   desc = "list_workspace_folders",
    -- },
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
