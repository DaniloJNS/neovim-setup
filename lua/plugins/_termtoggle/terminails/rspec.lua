local Terminal  = require('toggleterm.terminal').Terminal

function Docker_toggle()
  local current_line_cursor = Current_cursor_line_number()
  local path = Current_path()

  if not current_line_cursor then
    path = path .. ":" .. current_line_cursor
  end

  Terminal:new({
    cmd="docker-compose exec app rspec " .. path,
    direction = 'float',
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd("Closing terminal")
    end,
  }):toggle()
end

function Current_path()
  return vim.fn.expand("%")
end

function Current_cursor_line_number()
  return vim.api.nvim_win_get_cursor(0)[1]
end

vim.api.nvim_set_keymap("n", "<leader>rs", '<cmd>lua Docker_toggle()<CR>', {noremap = true, silent = true})
