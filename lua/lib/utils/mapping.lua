local vim = vim

local M = {}
local keymap = vim.api.nvim_set_keymap
local lkeymap = vim.api.nvim_buf_set_map
local opts = { noremap = true }

function M.nkeymap(key, map)
  keymap("n", key, map, opts)
end

function M.ikeymap(key, map)
  keymap("i", key, map, opts)
end

function M.vkeymap(key, map)
  keymap("v", key, map, opts)
end
function M.lnkeymap(key, map)
  lkeymap("n", key, map, opts)
end

return M
