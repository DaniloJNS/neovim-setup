local tools = require('tools')
local actions = require('telescope.actions')
local command_palette = require('command-palette')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_better,
        ["<C-j>"] = actions.move_selection_worse,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Esc>"] = actions.close
      },
    },
  },
  extensions = {
    command_palette = command_palette
  }
}

-- Load extensions
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('gh')
require('telescope').load_extension('command_palette')
-- Keymaps {{
  -- buffers {{
    tools.nkeymap('/', ':lua require("telescope-utils").search_in_buffer()<CR>')

    tools.ikeymap('<C-f>', '<Esc> :lua require("telescope-utils").search_in_buffer()<CR>')
  -- }}

  -- files {{
    tools.nkeymap('<C-f>', ':lua require("telescope-utils").search_files()<CR>')

    tools.nkeymap('<Leader>fg', '<Esc> :lua require("telescope.builtin").live_grep()<CR>')

    tools.nkeymap('<Leader>b', '<Esc> :lua require("telescope.builtin").buffers()<CR>')

    tools.nkeymap('<Leader>fd', '<Esc> :lua require("telescope-utils").search_dotfiles()<CR>')
  -- }}

    tools.nkeymap('<Leader>fh', '<Esc> :lua require("telescope.builtin").help_tags()<CR>')

    tools.nkeymap('<space>c', '<Esc> :Telescope command_palette<CR>')

    tools.nkeymap('<space>C', '<Esc> :lua require("telescope.builtin").colorscheme()<CR>')

    tools.nkeymap('<Leader>ac', '<Esc> :lua require("telescope.builtin").builtin()<CR>')
-- }}
