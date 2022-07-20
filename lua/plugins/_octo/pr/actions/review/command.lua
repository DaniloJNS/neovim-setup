local ui = require('plugins._octo.pr.actions.review.ui')
local M = {}

local callback = function (selected)
    if selected == "Add reviewer" then
        vim.api.nvim_exec(':<space>b', true)
    else
        vim.api.nvim_exec(':<space>b', true)
    end
end

function M.call ()
    ui(callback)
end

return M
