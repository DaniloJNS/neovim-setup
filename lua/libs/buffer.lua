local M = {}

function M.relative_path()
  return vim.fn.expand("%")
end

function M.get_line()
  return vim.fn.getline(".")
end

function M.get_line_number()
  return vim.api.nvim_win_get_cursor(0)[1]
end

function M.get_cwd()
  return vim.fn.getcwd()
end

function M.filetype()
  return vim.bo.filetype()
end

return M
