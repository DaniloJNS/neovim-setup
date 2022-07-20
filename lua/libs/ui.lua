
local M = {}

function M.select(options, prompt, callback)

    vim.ui.select(options, {
      prompt = prompt,
      telescope = require("telescope.themes").get_cursor(),
    }, callback)
end

return M

