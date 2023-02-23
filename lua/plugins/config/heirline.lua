local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

--- Blend two rgb colors using alpha
---@param color1 string | number first color
---@param color2 string | number second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
local function blend(color1, color2, alpha)
  color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
  color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
  local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
  local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return "#"
    .. string.format("%02x", math.min(255, math.max(r, 0)))
    .. string.format("%02x", math.min(255, math.max(g, 0)))
    .. string.format("%02x", math.min(255, math.max(b, 0)))
end

local function dim(color, n)
  return blend(color, "#000000", n)
end

local function setup_colors()
  return {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    -- git_del = utils.get_highlight("diffDeleted").fg,
    -- git_add = utils.get_highlight("diffAdded").fg,
    -- git_change = utils.get_highlight("diffChanged").fg,
  }
end

require("heirline").load_colors(setup_colors())

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.cmd("au ModeChanged *:*o redrawstatus")
    end
    self.once = true
  end,
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
  },
  provider = function(self)
    return " %2(" .. self.mode_names[self.mode] .. "%)"
  end,
  hl = function(self)
    local color = self:mode_color()
    return { fg = color, bold = true }
  end,
  update = {
    "ModeChanged",
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then
      self.lfilename = "[No Name]"
    end
    if not conditions.width_percent_below(#self.lfilename, 0.27) then
      self.lfilename = vim.fn.pathshorten(self.lfilename)
    end
  end,
  hl = "Directory",
  flexible = 2,
  {
    provider = function(self)
      return self.lfilename
    end,
  },
  {
    provider = function(self)
      return vim.fn.pathshorten(self.lfilename)
    end,
  },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

FileNameBlock = utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifer, FileName), unpack(FileFlags))

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = "Type",
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= "utf-8" and enc:upper()
  end,
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= "unix" and fmt:upper()
  end,
}

local FileSize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { "b", "k", "M", "G", "T", "P", "E" }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize <= 0 then
      return "0" .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
  end,
}

local FileLastModified = {
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date("%c", ftime)
  end,
}

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%3L%):%2c %P",
}

local ScrollBar = {
  static = {
    -- sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = "blue", bg = "bright_bg" },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach", "WinEnter" },

  provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  -- provider  = function(self)
  --     local names = {}
  --     for i, server in pairs(vim.lsp.buf_get_active_clients({ bufnr = 0 })) do
  --         table.insert(names, server.name)
  --     end
  --     return " [" .. table.concat(names, " ") .. "]"
  -- end,
  hl = { fg = "green", bold = true },
  on_click = {
    name = "heirline_LSP",
    callback = function()
      vim.schedule(function()
        vim.cmd("LspInfo")
      end)
    end,
  },
}

local Navic = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  static = {
    type_hl = {
      File = dim(utils.get_highlight("Directory").fg, 0.75),
      Module = dim(utils.get_highlight("@include").fg, 0.75),
      Namespace = dim(utils.get_highlight("@namespace").fg, 0.75),
      Package = dim(utils.get_highlight("@include").fg, 0.75),
      Class = dim(utils.get_highlight("@struct").fg, 0.75),
      Method = dim(utils.get_highlight("@method").fg, 0.75),
      Property = dim(utils.get_highlight("@property").fg, 0.75),
      Field = dim(utils.get_highlight("@field").fg, 0.75),
      Constructor = dim(utils.get_highlight("@constructor").fg, 0.75),
      Enum = dim(utils.get_highlight("@field").fg, 0.75),
      Interface = dim(utils.get_highlight("@type").fg, 0.75),
      Function = dim(utils.get_highlight("@function").fg, 0.75),
      Variable = dim(utils.get_highlight("@variable").fg, 0.75),
      Constant = dim(utils.get_highlight("@constant").fg, 0.75),
      String = dim(utils.get_highlight("@string").fg, 0.75),
      Number = dim(utils.get_highlight("@number").fg, 0.75),
      Boolean = dim(utils.get_highlight("@boolean").fg, 0.75),
      Array = dim(utils.get_highlight("@field").fg, 0.75),
      Object = dim(utils.get_highlight("@type").fg, 0.75),
      Key = dim(utils.get_highlight("@keyword").fg, 0.75),
      Null = dim(utils.get_highlight("@comment").fg, 0.75),
      EnumMember = dim(utils.get_highlight("@field").fg, 0.75),
      Struct = dim(utils.get_highlight("@struct").fg, 0.75),
      Event = dim(utils.get_highlight("@keyword").fg, 0.75),
      Operator = dim(utils.get_highlight("@operator").fg, 0.75),
      TypeParameter = dim(utils.get_highlight("@type").fg, 0.75),
    },
    -- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
    -- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require("nvim-navic").get_data() or {}
    local children = {}
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = { fg = self.type_hl[d.type] },
        },
        {
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
          hl = { fg = self.type_hl[d.type] },
          -- hl = self.type_hl[d.type],
          on_click = {
            callback = function(_, minwid)
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            minwid = pos,
            name = "heirline_navic",
          },
        },
      }
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = " → ",
          hl = { fg = "bright_fg" },
        })
      end
      table.insert(children, child)
    end
    self[1] = self:new(children, 1)
  end,
  update = "CursorMoved",
  hl = { fg = "gray" },
}

local Diagnostics = {

  condition = conditions.has_diagnostics,
  update = { "DiagnosticChanged", "BufEnter" },
  on_click = {
    callback = function()
      require("trouble").toggle({ mode = "document_diagnostics" })
    end,
    name = "heirline_diagnostics",
  },

  static = {
    -- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    -- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    -- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    -- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = "DiagnosticError",
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = "DiagnosticWarn",
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = "DiagnosticInfo",
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = "DiagnosticHint",
  },
}

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  on_click = {
    callback = function(self, minwid, nclicks, button)
      vim.defer_fn(function()
        vim.cmd("Lazygit %:p:h")
      end, 100)
    end,
    name = "heirline_git",
    update = false,
  },

  hl = { fg = "orange" },

  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "(",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = "diffAdded",
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = "diffDeleted",
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = "diffChanged",
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

local Snippets = {
  condition = function()
    return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
  end,
  provider = function()
    local forward = (vim.fn["UltiSnips#CanJumpForwards"]() == 1) and " " or ""
    local backward = (vim.fn["UltiSnips#CanJumpBackwards"]() == 1) and " " or ""
    return backward .. forward
  end,
  hl = { fg = "red", bold = true },
}

local DAPMessages = {
  condition = function()
    local session = require("dap").session()
    return session ~= nil
  end,
  provider = function()
    return " " .. require("dap").status() .. " "
  end,
  hl = "Debug",
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_into()
      end,
      name = "heirline_dap_step_into",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_out()
      end,
      name = "heirline_dap_step_out",
    },
  },
  { provider = " " },
  {
    provider = " ",
    on_click = {
      callback = function()
        require("dap").step_over()
      end,
      name = "heirline_dap_step_over",
    },
  },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "green" },
    on_click = {
      callback = function()
        require("dap").run_last()
      end,
      name = "heirline_dap_run_last",
    },
  },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "red" },
    on_click = {
      callback = function()
        require("dap").terminate()
        require("dapui").close({})
      end,
      name = "heirline_dap_close",
    },
  },
  { provider = " " },
  --       ﰇ  
}

local WorkDir = {
  init = function(self)
    self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
    local cwd = vim.fn.getcwd(0)
    self.cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#self.cwd, 0.27) then
      self.cwd = vim.fn.pathshorten(self.cwd)
    end
  end,
  hl = { fg = "blue", bold = true },
  on_click = {
    callback = function()
      vim.cmd("NvimTreeToggle")
    end,
    name = "heirline_workdir",
  },

  flexible = 1,
  {
    provider = function(self)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. self.cwd .. trail .. " "
    end,
  },
  {
    provider = function(self)
      local cwd = vim.fn.pathshorten(self.cwd)
      local trail = self.cwd:sub(-1) == "/" and "" or "/"
      return self.icon .. cwd .. trail .. " "
    end,
  },
  {
    provider = "",
  },
}

local HelpFilename = {
  condition = function()
    return vim.bo.filetype == "help"
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ":t")
  end,
  hl = "Directory",
}

local TerminalName = {
  -- icon = ' ', -- 
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      return " " .. tname
    end,
    hl = { fg = "blue", bold = true },
  },
  { provider = " - " },
  {
    provider = function()
      return vim.b.term_title
    end,
  },
  {
    provider = function()
      local id = require("terminal"):current_term_index()
      return " " .. (id or "Exited")
    end,
    hl = { bold = true, fg = "blue" },
  },
}

local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = "SPELL ",
  hl = { bold = true, fg = "orange" },
}

local SearchCount = {
  condition = function()
    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
  end,
}

local MacroRec = {
  condition = function()
    return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
  end,
  provider = " ",
  hl = { fg = "orange", bold = true },
  utils.surround({ "[", "]" }, nil, {
    provider = function()
      return vim.fn.reg_recording()
    end,
    hl = { fg = "green", bold = true },
  }),
}

ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode, Snippets })

local Align = { provider = "%=" }
local Space = { provider = " " }

local DefaultStatusline = {
  ViMode,
  SearchCount,
  MacroRec,
  Space,
  Spell,
  WorkDir,
  FileNameBlock,
  { provider = "%<" },
  Space,
  Git,
  Space,
  Diagnostics,
  Align,
  { flexible = 3, { Navic, Space }, { provider = "" } },
  Align,
  DAPMessages,
  LSPActive,
  -- Space,
  -- UltTest,
  Space,
  FileType,
  { flexible = 3, { Space, FileEncoding }, { provider = "" } },
  Space,
  Ruler,
  Space,
  ScrollBar,
  -- {
  --     provider = function()
  --         return vim.inspect(utils.get_highlight('StatusLine'))
  --     end
  -- }
}

local InactiveStatusline = {
  condition = conditions.is_not_active,
  { hl = { fg = "gray", force = true }, WorkDir },
  FileNameBlock,
  { provider = "%<" },
  Align,
}

local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "^git.*", "fugitive" },
    })
  end,
  FileType,
  { provider = "%q" },
  Space,
  HelpFilename,
  Align,
}

local GitStatusline = {
  condition = function()
    return conditions.buffer_matches({
      filetype = { "^git.*", "fugitive" },
    })
  end,
  FileType,
  Space,
  {
    provider = function()
      return vim.fn.FugitiveStatusline()
    end,
  },
  Space,
  Align,
}

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,
  hl = { bg = "dark_red" },
  { condition = conditions.is_active, ViMode, Space },
  FileType,
  Space,
  TerminalName,
  Align,
}

local StatusLines = {

  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,

  static = {
    mode_colors = {
      n = "red",
      i = "green",
      v = "cyan",
      V = "cyan",
      ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "green",
    },
    mode_color = function(self)
      local mode = conditions.is_active() and vim.fn.mode() or "n"
      return self.mode_colors[mode]
    end,
  },

  fallthrough = false,

  -- GitStatusline,
  SpecialStatusline,
  TerminalStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

local CloseButton = {
  condition = function(self)
    return not vim.bo.modified
  end,
  -- update = 'BufEnter',
  update = { "WinNew", "WinClosed", "BufEnter" },
  { provider = " " },
  {
    provider = " ",
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_win_close(minwid, true)
      end,
      minwid = function()
        return vim.api.nvim_get_current_win()
      end,
      name = "heirline_winbar_close_button",
    },
  },
}

local WinBar = {
  fallthrough = false,
  {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive" },
      })
    end,
    init = function()
      vim.opt_local.winbar = nil
    end,
  },
  {
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    utils.surround({ "", "" }, "dark_red", {
      FileType,
      Space,
      TerminalName,
      CloseButton,
    }),
  },
  utils.surround({ "", "" }, "bright_bg", {
    hl = function()
      if conditions.is_not_active() then
        return { fg = "gray", force = true }
      end
    end,

    FileNameBlock,
    CloseButton,
  }),
}

local TablineBufnr = {
  provider = function(self)
    return tostring(self.bufnr) .. ". "
  end,
  hl = "Comment",
}

local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
        or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
        return "  "
      else
        return ""
      end
    end,
    hl = { fg = "orange" },
  },
  -- {
  --     condition = function(self)
  --         return not vim.api.nvim_buf_is_loaded(self.bufnr)
  --     end,
  --     -- a downright arrow
  --     provider = "", -- 
  --     hl = { fg = "gray" },
  -- },
}

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return "TabLineSel"
    elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      return { fg = "gray" }
    else
      return "TabLine"
    end
  end,
  on_click = {
    callback = function(_, minwid)
      vim.api.nvim_win_set_buf(0, minwid)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  TablineBufnr,
  FileIcon,
  TablineFileName,
  TablineFileFlags,
}

local TablineCloseButton = {
  condition = function(self)
    -- return not vim.bo[self.bufnr].modified
    return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
  end,
  { provider = " " },
  { -- ✗    
    provider = " ",
    hl = { fg = "gray" },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_buf_delete(minwid, { force = false })
        vim.cmd.redrawtabline()
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_close_buffer_callback",
    },
  },
}

local TablinePicker = {
  condition = function(self)
    return self._show_picker
  end,
  init = function(self)
    local bufname = vim.api.nvim_buf_get_name(self.bufnr)
    bufname = vim.fn.fnamemodify(bufname, ":t")
    local label = bufname:sub(1, 1)
    local i = 2
    while self._picker_labels[label] do
      label = bufname:sub(i, i)
      if i > #bufname then
        break
      end
      i = i + 1
    end
    self._picker_labels[label] = self.bufnr
    self.label = label
  end,
  provider = function(self)
    return self.label
  end,
  hl = { fg = "red", bold = true },
}

vim.keymap.set("n", "gbp", function()
  local tabline = require("heirline").tabline
  local buflist = tabline._buflist[1]
  buflist._picker_labels = {}
  buflist._show_picker = true
  vim.cmd.redrawtabline()
  local char = vim.fn.getcharstr()
  local bufnr = buflist._picker_labels[char]
  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  end
  buflist._show_picker = false
  vim.cmd.redrawtabline()
end)

local TablineBufferBlock = utils.surround({ "", "" }, function(self)
  if self.is_active then
    return utils.get_highlight("TabLineSel").bg
  else
    return utils.get_highlight("TabLine").bg
  end
end, { TablinePicker, TablineFileNameBlock, TablineCloseButton })

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = " ", hl = { fg = "gray" } },
  { provider = " ", hl = { fg = "gray" } }
)

local Tabpage = {
  provider = function(self)
    local n = #vim.api.nvim_tabpage_list_wins(self.tabpage)
    return "%" .. self.tabnr .. "T " .. self.tabnr .. "(" .. n .. ")" .. " %T"
  end,
  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end,
  update = { "TabNew", "TabClosed", "TabEnter", "TabLeave", "WinNew", "WinClosed" },
}

local TabpageClose = {
  provider = " %999X %X",
  hl = "TabLine",
}

local TabPages = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  {
    provider = "%=",
  },
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.api.nvim_buf_get_option(bufnr, "filetype") == "NvimTree" then
      self.title = "NvimTree"
      return true
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return "TablineSel"
    else
      return "Tabline"
    end
  end,
}

local TabLine = {
  -- update = {
  --     "BufNew",
  --     "BufDelete",
  --     "WinEnter",
  --     "BufEnter",
  --     "BufModifiedSet",
  --     callback = function()
  --         -- print("callback")
  --     end,
  -- },
  TabLineOffset,
  BufferLine,
  -- utils.make_flexible_component(1, {provider = 'aaaaaaaaaaaaaaaaaaa'}, {provider = 'bbbb'}),
  TabPages,
}

local Stc = {
  static = {
    ---@return {name:string, text:string, texthl:string}[]
    get_signs = function()
      -- local buf = vim.api.nvim_get_current_buf()
      local buf = vim.fn.expand("%")
      return vim.tbl_map(function(sign)
        return vim.fn.sign_getdefined(sign.name)[1]
      end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
    end,

    resolve = function(self, name)
      for pat, cb in pairs(self.handlers) do
        if name:match(pat) then
          return cb
        end
      end
    end,

    handlers = {
      ["GitSigns.*"] = function(args)
        require("gitsigns").preview_hunk_inline()
      end,
      -- ["Dap.*"] = function(args)
      --   require("dap").toggle_breakpoint()
      -- end,
      -- ["Diagnostic.*"] = function(args)
      --   vim.diagnostic.open_float() -- { pos = args.mousepos.line - 1, relative = "mouse" })
      -- end,
    },
  },
  -- init = function(self)
  --     local signs = {}
  --     for _, s in ipairs(self.get_signs()) do
  --         if s.name:find("GitSign") then
  --             self.git_sign = s
  --         else
  --             table.insert(signs, s)
  --         end
  --     end
  --     self.signs = signs
  -- end,
  {
    provider = "%s",
    -- provider = function(self)
    --     -- return vim.inspect({ self.signs, self.git_sign })
    --     local children = {}
    --     for _, sign in ipairs(self.signs) do
    --         table.insert(children, {
    --             provider = sign.text,
    --             hl = sign.texthl,
    --         })
    --     end
    --     self[1] = self:new(children, 1)
    -- end,

    on_click = {
      callback = function(self, ...)
        local mousepos = vim.fn.getmousepos()
        vim.api.nvim_win_set_cursor(0, { mousepos.line, mousepos.column })
        local sign_at_cursor = vim.fn.screenstring(mousepos.screenrow, mousepos.screencol)
        if sign_at_cursor ~= "" then
          local args = {
            mousepos = mousepos,
          }
          local signs = vim.fn.sign_getdefined()
          for _, sign in ipairs(signs) do
            local glyph = sign.text:gsub(" ", "")
            if sign_at_cursor == glyph then
              vim.defer_fn(function()
                self:resolve(sign.name)(args)
              end, 10)
              return
            end
          end
        end
      end,
      name = "heirline_signcol_callback",
      update = true,
    },
  },
  {
    provider = "%=%4{v:virtnum ? '' : &nu ? (&rnu && v:relnum ? v:relnum : v:lnum) . ' ' : ''}",
  },
  {
    provider = "%{% &fdc ? '%C ' : '' %}",
  },
  -- {
  --     provider = function(self)
  --         return self.git_sign and self.git_sign.text
  --     end,
  --     hl = function(self)
  --         return self.git_sign and self.git_sign.texthl
  --     end,
  -- },
}

require("heirline").setup({
  statusline = StatusLines,
  winbar = WinBar,
  tabline = TabLine,
  -- statuscolumn = Stc,
})
-- vim.o.statuscolumn = require("heirline").eval_statuscolumn()

vim.api.nvim_create_augroup("Heirline", { clear = true })

vim.cmd([[au Heirline FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- vim.cmd("au BufWinEnter * if &bt != '' | setl stc= | endif")

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "HeirlineInitWinbar",
--   callback = function(args)
--     local buf = args.buf
--     local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
--     local filetype = vim.tbl_contains({ "gitcommit", "fugitive", "Trouble", "packer" }, vim.bo[buf].filetype)
--     if buftype or filetype then
--       args.data.ok = false
--     end
--   end,
--   group = "Heirline",
-- })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local colors = setup_colors()
    utils.on_colorscheme(colors)
  end,
  group = "Heirline",
})