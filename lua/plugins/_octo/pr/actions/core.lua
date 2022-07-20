local pull_request = require('plugins._octo.pr.actions.pull.command')
local octo_buffer = require('plugins._octo.utils.buffer')

local M = {}

function M.call()
    if not octo_buffer then return nil end

    if octo_buffer:isPullRequest() then
        pull_request.call()
        return print("Pull Request")
    elseif octo_buffer:isReviewThread() then
        return print("Review thread")
    elseif octo_buffer:isIssue() then
        return print("Issue")
    elseif octo_buffer:isRepo() then
        return print("Repo")
    end
end

return M
