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
      filesystem = neovim.get_icon("neotree", "FolderClosed"),
      buffers = neovim.get_icon("neotree", "DefaultFile"),
      git_status = neovim.get_icon("neotree", "Git"),
      diagnostics = neovim.get_icon("neotree", "Diagnostic"),
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = neovim.get_icon("neotree", "FolderClosed"),
      folder_open = neovim.get_icon("neotree", "FolderOpen"),
      folder_empty = neovim.get_icon("neotree", "FolderEmpty"),
      default = neovim.get_icon("neotree", "DefaultFile"),
    },
    git_status = {
      symbols = {
        added = neovim.get_icon("neotree", "GitAdd"),
        deleted = neovim.get_icon("neotree", "GitDelete"),
        modified = neovim.get_icon("neotree", "GitChange"),
        renamed = neovim.get_icon("neotree", "GitRenamed"),
        untracked = neovim.get_icon("neotree", "GitUntracked"),
        ignored = neovim.get_icon("neotree", "GitIgnored"),
        unstaged = neovim.get_icon("neotree", "GitUnstaged"),
        staged = neovim.get_icon("neotree", "GitStaged"),
        conflict = neovim.get_icon("neotree", "GitConflict"),
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
        -- O = "system_open",
        h = "toggle_hidden",
      },
    },
    -- TODO: create function for open in github
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
