local mappings = require('mappings')
local actions = require('telescope.actions')
local command_palette = require('command-palette')
local trouble = require("trouble.providers.telescope")


require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["<C-j>"] = actions.move_selection_better,
        ["<C-k>"] = actions.move_selection_worse,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Esc>"] = actions.close
      },
      n = { ["<c-t>"] = trouble.open_with_trouble }
    },
  },
  pickers = {
    lsp_code_actions = {
        theme = "cursor"
    },
    code_action = {
        theme = "cursor"
    },
    lsp_workspace_diagnostics = {
        theme = "dropdown"
    },
    rename = {
        theme = "cursor"
    }
  },
  extensions = {
    command_palette = command_palette,
    ["ui-select"] = {
        require("telescope.themes").get_cursor {
        -- even more opts
        }
    }
  }
}
-- Load extensions
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('gh')
require('telescope').load_extension('command_palette')
require("telescope").load_extension("ui-select")

-- Keymaps {{
  -- buffers {{
    mappings.nkeymap('/', ':lua require("telescope-utils").search_in_buffer()<CR>')

    mappings.ikeymap('<C-f>', '<Esc> :lua require("telescope-utils").search_in_buffer()<CR>')
  -- }}

  -- files {{
    mappings.nkeymap('<C-f>', ':lua require("telescope-utils").search_files()<CR>')

    mappings.nkeymap('<Leader>fg', '<Esc> :lua require("telescope.builtin").live_grep()<CR>')

    mappings.nkeymap('<Leader><CR>', '<Esc> :lua vim.lsp.buf.code_action()<CR>')

    mappings.nkeymap('<Leader>b', '<Esc> :lua require("telescope.builtin").buffers()<CR>')

    mappings.nkeymap('<Leader>fd', '<Esc> :lua require("telescope-utils").search_dotfiles()<CR>')
  -- }}

    mappings.nkeymap('<Leader>fh', '<Esc> :lua require("telescope.builtin").help_tags()<CR>')

    mappings.nkeymap('<space>k', '<Esc> :Telescope command_palette<CR>')

    mappings.nkeymap('<space>C', '<Esc> :lua require("telescope.builtin").colorscheme()<CR>')

    mappings.nkeymap('<Leader>ac', '<Esc> :lua require("telescope.builtin").builtin()<CR>')

    mappings.nkeymap('<Leader>ch', '<Esc> :Cheatsheet')
-- }}
