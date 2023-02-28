local heirline = require "heirline"
if not neovim.status then return end
local C = require "default_theme.colors"

local function setup_colors()
  local Normal = neovim.get_hlgroup("Normal", { fg = C.fg, bg = C.bg })
  local Comment = neovim.get_hlgroup("Comment", { fg = C.grey_2, bg = C.bg })
  local Error = neovim.get_hlgroup("Error", { fg = C.red, bg = C.bg })
  local StatusLine = neovim.get_hlgroup("StatusLine", { fg = C.fg, bg = C.grey_4 })
  local TabLine = neovim.get_hlgroup("TabLine", { fg = C.grey, bg = C.none })
  local TabLineSel = neovim.get_hlgroup("TabLineSel", { fg = C.fg, bg = C.none })
  local WinBar = neovim.get_hlgroup("WinBar", { fg = C.grey_2, bg = C.bg })
  local WinBarNC = neovim.get_hlgroup("WinBarNC", { fg = C.grey, bg = C.bg })
  local Conditional = neovim.get_hlgroup("Conditional", { fg = C.purple_1, bg = C.grey_4 })
  local String = neovim.get_hlgroup("String", { fg = C.green, bg = C.grey_4 })
  local TypeDef = neovim.get_hlgroup("TypeDef", { fg = C.yellow, bg = C.grey_4 })
  local GitSignsAdd = neovim.get_hlgroup("GitSignsAdd", { fg = C.green, bg = C.grey_4 })
  local GitSignsChange = neovim.get_hlgroup("GitSignsChange", { fg = C.orange_1, bg = C.grey_4 })
  local GitSignsDelete = neovim.get_hlgroup("GitSignsDelete", { fg = C.red_1, bg = C.grey_4 })
  local DiagnosticError = neovim.get_hlgroup("DiagnosticError", { fg = C.red_1, bg = C.grey_4 })
  local DiagnosticWarn = neovim.get_hlgroup("DiagnosticWarn", { fg = C.orange_1, bg = C.grey_4 })
  local DiagnosticInfo = neovim.get_hlgroup("DiagnosticInfo", { fg = C.white_2, bg = C.grey_4 })
  local DiagnosticHint = neovim.get_hlgroup("DiagnosticHint", { fg = C.yellow_1, bg = C.grey_4 })
  local HeirlineInactive = neovim.get_hlgroup("HeirlineInactive", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("inactive", C.grey_7)
  local HeirlineNormal = neovim.get_hlgroup("HeirlineNormal", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("normal", C.blue)
  local HeirlineInsert = neovim.get_hlgroup("HeirlineInsert", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("insert", C.green)
  local HeirlineVisual = neovim.get_hlgroup("HeirlineVisual", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("visual", C.purple)
  local HeirlineReplace = neovim.get_hlgroup("HeirlineReplace", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("replace", C.red_1)
  local HeirlineCommand = neovim.get_hlgroup("HeirlineCommand", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("command", C.yellow_1)
  local HeirlineTerminal = neovim.get_hlgroup("HeirlineTerminal", { fg = nil }).fg
    or neovim.status.hl.lualine_mode("inactive", HeirlineInsert)

  local colors = {
    close_fg = Error.fg,
    fg = StatusLine.fg,
    bg = StatusLine.bg,
    section_fg = StatusLine.fg,
    section_bg = StatusLine.bg,
    git_branch_fg = Conditional.fg,
    mode_fg = StatusLine.bg,
    treesitter_fg = String.fg,
    scrollbar = TypeDef.fg,
    git_added = GitSignsAdd.fg,
    git_changed = GitSignsChange.fg,
    git_removed = GitSignsDelete.fg,
    diag_ERROR = DiagnosticError.fg,
    diag_WARN = DiagnosticWarn.fg,
    diag_INFO = DiagnosticInfo.fg,
    diag_HINT = DiagnosticHint.fg,
    winbar_fg = WinBar.fg,
    winbar_bg = WinBar.bg,
    winbarnc_fg = WinBarNC.fg,
    winbarnc_bg = WinBarNC.bg,
    tabline_bg = StatusLine.bg,
    tabline_fg = StatusLine.bg,
    buffer_fg = Comment.fg,
    buffer_path_fg = WinBarNC.fg,
    buffer_close_fg = Comment.fg,
    buffer_bg = StatusLine.bg,
    buffer_active_fg = Normal.fg,
    buffer_active_path_fg = WinBarNC.fg,
    buffer_active_close_fg = Error.fg,
    buffer_active_bg = Normal.bg,
    buffer_visible_fg = Normal.fg,
    buffer_visible_path_fg = WinBarNC.fg,
    buffer_visible_close_fg = Error.fg,
    buffer_visible_bg = Normal.bg,
    buffer_overflow_fg = Comment.fg,
    buffer_overflow_bg = StatusLine.bg,
    buffer_picker_fg = Error.fg,
    tab_close_fg = Error.fg,
    tab_close_bg = StatusLine.bg,
    tab_fg = TabLine.fg,
    tab_bg = TabLine.bg,
    tab_active_fg = TabLineSel.fg,
    tab_active_bg = TabLineSel.bg,
    inactive = HeirlineInactive,
    normal = HeirlineNormal,
    insert = HeirlineInsert,
    visual = HeirlineVisual,
    replace = HeirlineReplace,
    command = HeirlineCommand,
    terminal = HeirlineTerminal,
  }

  for _, section in ipairs {
    "git_branch",
    "file_info",
    "git_diff",
    "diagnostics",
    "lsp",
    "macro_recording",
    "mode",
    "cmd_info",
    "treesitter",
    "nav",
  } do
    if not colors[section .. "_bg"] then colors[section .. "_bg"] = colors["section_bg"] end
    if not colors[section .. "_fg"] then colors[section .. "_fg"] = colors["section_fg"] end
  end
  return colors
end

--- a submodule of heirline specific functions and aliases
neovim.status.heirline = {}

--- A helper function to get the type a tab or buffer is
-- @param self the self table from a heirline component function
-- @param prefix the prefix of the type, either "tab" or "buffer" (Default: "buffer")
-- @return the string of prefix with the type (i.e. "_active" or "_visible")
function neovim.status.heirline.tab_type(self, prefix)
  local tab_type = ""
  if self.is_active then
    tab_type = "_active"
  elseif self.is_visible then
    tab_type = "_visible"
  end
  return (prefix or "buffer") .. tab_type
end

--- Make a list of buffers, rendering each buffer with the provided component
---@param component table
---@return table
neovim.status.heirline.make_buflist = function(component)
  local overflow_hl = neovim.status.hl.get_attributes("buffer_overflow", true)
  return require("heirline.utils").make_buflist(
    neovim.status.utils.surround(
      "tab",
      function(self)
        return {
          main = neovim.status.heirline.tab_type(self) .. "_bg",
          left = "tabline_bg",
          right = "tabline_bg",
        }
      end,
      { -- bufferlist
        init = function(self) self.tab_type = neovim.status.heirline.tab_type(self) end,
        on_click = { -- add clickable component to each buffer
          callback = function(_, minwid) vim.api.nvim_win_set_buf(0, minwid) end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_buffer_callback",
        },
        { -- add buffer picker functionality to each buffer
          condition = function(self) return self._show_picker end,
          update = false,
          init = function(self)
            local bufname = neovim.status.provider.filename { fallback = "empty_file" }(self)
            local label = bufname:sub(1, 1)
            local i = 2
            while label ~= " " and self._picker_labels[label] do
              if i > #bufname then break end
              label = bufname:sub(i, i)
              i = i + 1
            end
            self._picker_labels[label] = self.bufnr
            self.label = label
          end,
          provider = function(self)
            return neovim.status.provider.str { str = self.label, padding = { left = 1, right = 1 } }
          end,
          hl = neovim.status.hl.get_attributes "buffer_picker",
        },
        component, -- create buffer component
      },
      false -- disable surrounding
    ),
    { provider = neovim.get_icon "ArrowLeft" .. " ", hl = overflow_hl },
    { provider = neovim.get_icon "ArrowRight" .. " ", hl = overflow_hl },
    function() return vim.t.bufs end, -- use neovim bufs variable
    false -- disable internal caching
  )
end

--- Alias to require("heirline.utils").make_tablist
neovim.status.heirline.make_tablist = require("heirline.utils").make_tablist

--- Run the buffer picker and execute the callback function on the selected buffer
-- @param callback function with a single parameter of the buffer number
function neovim.status.heirline.buffer_picker(callback)
  local tabline = require("heirline").tabline
  local buflist = tabline and tabline._buflist[1]
  if buflist then
    local prev_showtabline = vim.opt.showtabline
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.opt.showtabline = 2
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then callback(bufnr) end
    buflist._show_picker = false
    vim.opt.showtabline = prev_showtabline
    vim.cmd.redrawtabline()
  end
end

heirline.load_colors(setup_colors())
local heirline_opts = {
  { -- statusline
    hl = { fg = "fg", bg = "bg" },
    neovim.status.component.mode(),
    neovim.status.component.git_branch(),
    -- TODO: REMOVE THIS WITH v3
    -- neovim.status.component.file_info(
    --   (neovim.has "bufferline" or vim.g.heirline_bufferline)
    --       and { filetype = {}, filename = false, file_modified = false }
    --     or nil
    -- ),
    -- neovim.status.component.file_info { filetype = {}, filename = false, file_modified = false },
    neovim.status.component.git_diff(),
    neovim.status.component.diagnostics(),
    neovim.status.component.fill(),
    neovim.status.component.cmd_info(),
    neovim.status.component.fill(),
    neovim.status.component.lsp(),
    neovim.status.component.treesitter(),
    neovim.status.component.nav(),
    neovim.status.component.mode { surround = { separator = "right" } },
  },
  { -- winbar
    static = {
      disabled = {
        buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
        filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
      },
    },
    init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
    fallthrough = false,
    {
      condition = function(self)
        return vim.opt.diff:get() or neovim.status.condition.buffer_matches(self.disabled or {})
      end,
      init = function() vim.opt_local.winbar = nil end,
    },
    neovim.status.component.file_info {
      condition = function() return not neovim.status.condition.is_active() end,
      unique_path = {},
      file_icon = { hl = neovim.status.hl.file_icon "winbar" },
      file_modified = false,
      file_read_only = false,
      hl = neovim.status.hl.get_attributes("winbarnc", true),
      surround = false,
      update = "BufEnter",
    },
    neovim.status.component.breadcrumbs { hl = neovim.status.hl.get_attributes("winbar", true) },
  },
  vim.g.heirline_bufferline -- TODO v3: remove this option and make bufferline default
      and { -- bufferline
        { -- file tree padding
          condition = function(self)
            self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
            return neovim.status.condition.buffer_matches(
              { filetype = { "neo%-tree", "NvimTree" } },
              vim.api.nvim_win_get_buf(self.winid)
            )
          end,
          provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid)) end,
          hl = { bg = "tabline_bg" },
        },
        neovim.status.heirline.make_buflist(neovim.status.component.tabline_file_info()), -- component for each buffer tab
        neovim.status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
        { -- tab list
          condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
          neovim.status.heirline.make_tablist { -- component for each tab
            provider = neovim.status.provider.tabnr(),
            hl = function(self)
              return neovim.status.hl.get_attributes(neovim.status.heirline.tab_type(self, "tab"), true)
            end,
          },
          { -- close button for current tab
            provider = neovim.status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
            hl = neovim.status.hl.get_attributes("tab_close", true),
            on_click = { callback = neovim.close_tab, name = "heirline_tabline_close_tab_callback" },
          },
        },
      }
    or nil,
}
-- heirline.setup(heirline_opts[1], heirline_opts[2], heirline_opts[3])
heirline.setup(heirline_opts[1])

local augroup = vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroColorScheme",
  group = augroup,
  desc = "Refresh heirline colors",
  callback = function() require("heirline.utils").on_colorscheme(setup_colors()) end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "HeirlineInitWinbar",
  group = augroup,
  desc = "Disable winbar for some filetypes",
  callback = function()
    if
      vim.opt.diff:get()
      or neovim.status.condition.buffer_matches(require("heirline").winbar.disabled or {
        buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
        filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
      }) -- TODO v3: remove the default fallback here
    then
      vim.opt_local.winbar = nil
    end
  end,
})
