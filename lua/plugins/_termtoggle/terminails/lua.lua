local Terminal = require('plugins._termtoggle.terminails.default')

function Get_buf_path()
  return vim.fn.expand("%")
end

function Lua_toggle()
  local path = Get_buf_path()
  local cmd = "lua " .. path

  Terminal(cmd, "vertical")
end

vim.api.nvim_set_keymap("n", "<leader>la", '<cmd>lua Lua_toggle()<CR>', {noremap = true, silent = true})
