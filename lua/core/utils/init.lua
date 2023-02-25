
local stdpath = vim.fn.stdpath
local tbl_insert = table.insert
local map = vim.keymap.set

-- Global variable
_G.neovim = {}

-- FIXME: create a togglable termiminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function neovim.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end


function neovim.deprecate(old, new)
  Util.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), { title = "LazyVim" })
end

require('core.utils.general')
require('core.utils.plugins')

return neovim
