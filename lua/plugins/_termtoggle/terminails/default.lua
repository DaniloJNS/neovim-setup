local Factory = require('plugins._termtoggle.factory')

return function(cmd, direction)
    Factory({
      cmd= cmd,
      direction = direction,
      close_on_exit = true,
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("Closing terminal")
      end,
    })
end

