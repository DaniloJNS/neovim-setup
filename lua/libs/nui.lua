---@diagnostic disable-next-line: unused-local
local mappings = require('mappings')

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local input = Input({
  position = "20%",
  size = {
      width = 20,
      height = 2,
  },
  relative = "editor",
  border = {
    style = "rounded",
    text = {
        top = "How old are you?",
        top_align = "center",
    },
  },
  win_options = {
    winblend = 10,
    winhighlight = "Normal:Normal",
  },
}, {
  prompt = "> ",
  default_value = "42",
  on_close = function()
    print("Input closed!")
  end,
  on_submit = function(value)
    print("You are " .. value .. " years old")
  end,
})
-- mount/open the component

function run()
    input:mount()
end
-- unmount component when cursor leaves buffer
input:on(event.BufLeave, function()
  input:unmount()
end)

vim.api.nvim_set_keymap("n", "<leader>ra", '<cmd>lua run()<CR>', {noremap = true, silent = true})
