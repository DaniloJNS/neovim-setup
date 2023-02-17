local icons = require("core.icons")

require("neo-tree").setup({
  close_if_last_window = true,
  enable_diagnostics = false,
  sources = {
    "filesystem",
    "buffers",
    "git_status",
  },
  source_selector = {
    winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = icons.files.FolderClosed,
      buffers = icons.files.DefaultFile,
      git_status = icons.git.Git,
      diagnostics = icons.lsp.Diagnostic,
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = icons.files.FolderClosed,
      folder_open = icons.files.FolderOpen,
      folder_empty = icons.files.FolderEmpty,
      default = icons.files.DefaultFile,
    },
    git_status = {
      symbols = {
        added = icons.GitAdd,
        deleted = icons.GitDelete,
        modified = icons.GitChange,
        renamed = icons.GitRenamed,
        untracked = icons.GitUntracked,
        ignored = icons.GitIgnored,
        unstaged = icons.GitUnstaged,
        staged = icons.GitStaged,
        conflict = icons.GitConflict,
      },
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      o = "open",
      H = "prev_source",
      L = "next_source",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        O = "system_open",
        h = "toggle_hidden",
      },
    },
    -- commands = {
    --   system_open = function(state)
    --     astronvim.system_open(state.tree:get_node():get_id())
    --   end,
    -- },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_)
        vim.opt_local.signcolumn = "auto"
      end,
    },
  },
})
