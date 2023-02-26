-- -- diagnostics
-- local function setup_diagnostics()
--   for name, icon in pairs(require("config").icons.diagnostics) do
--     name = "DiagnosticSign" .. name
--     vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
--   end
--   vim.diagnostic.config({
--     underline = true,
--     update_in_insert = false,
--     virtual_text = { spacing = 4, prefix = "●" },
--     severity_sort = true,
--   })
-- end


local signs = {
  { name = "DiagnosticSignError", text = neovim.get_icon("lsp", "DiagnosticError") },
  { name = "DiagnosticSignWarn", text = neovim.get_icon("lsp", "DiagnosticWarn") },
  { name = "DiagnosticSignHint", text = neovim.get_icon("lsp", "DiagnosticHint") },
  { name = "DiagnosticSignInfo", text = neovim.get_icon("lsp", "DiagnosticInfo") },
  { name = "DiagnosticSignError", text = neovim.get_icon("lsp", "DiagnosticError") },
  { name = "DapStopped", text = neovim.get_icon("lsp", "DapStopped"), texthl = "DiagnosticWarn" },
  { name = "DapBreakpoint", text = neovim.get_icon("lsp", "DapBreakpoint"), texthl = "DiagnosticInfo" },
  { name = "DapBreakpointRejected", text = neovim.get_icon("lsp", "DapBreakpointRejected"), texthl = "DiagnosticError" },
  { name = "DapBreakpointCondition", text = neovim.get_icon("lsp", "DapBreakpointCondition"), texthl = "DiagnosticInfo" },
  { name = "DapLogPoint", text = neovim.get_icon("lsp", "DapLogPoint"), texthl = "DiagnosticInfo" },
}

for _, sign in ipairs(signs) do
  if not sign.texthl then sign.texthl = sign.name end
  vim.fn.sign_define(sign.name, sign)
end

neovim.lsp.diagnostics = {
  off = {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  },
  on = {
    virtual_text = true,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focused = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  },
}
vim.diagnostic.config(neovim.lsp.diagnostics[vim.g.diagnostics_enabled and "on" or "off"])
