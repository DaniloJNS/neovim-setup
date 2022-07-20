local octo_buffer = require('plugins._octo.utils.buffer')
local buffer = require('libs.buffer')
local reviewer = require('plugins._octo.pr.actions.review.command')

local M = {}
-- the fields of a pull request will be defined through their position in the buffer
function M.call()
    if not octo_buffer then return nil end
    local line_number = buffer.get_line_number()

    if line_number == 10 then
        reviewer.call()
    end

    print(octo_buffer:get_body_at_cursor())
end

return M
