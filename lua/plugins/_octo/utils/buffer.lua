local bufnr = vim.api.nvim_get_current_buf()
local buff= octo_buffers[bufnr]

if vim.bo.filetype == 'octo' then
    return buff
else
    return nil
end
