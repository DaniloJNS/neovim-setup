require("plugins.lsp.format").autoformat = false
-- setup formatting and keymaps
neovim.lsp_on_attach(function(client, buffer)
  require("plugins.lsp.format").on_attach(client, buffer)
  require("plugins.lsp.keymaps").on_attach(client, buffer)
end)

local servers_config = {
  -- LSP Server Settings
  servers = {
    jsonls = {},
    lua_ls = {
      -- mason = false, -- set to false if you don't want this server to be installed with mason
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  },
  setup = {},
}

local function setup_handler(server)
  local servers = servers_config.servers
  local server_opts = servers[server] or {}
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  server_opts.capabilities = capabilities
  if servers_config.setup[server] then
    if servers_config.setup[server](server, server_opts) then
      return
    end
  elseif servers_config.setup["*"] then
    if servers_config.setup["*"](server, server_opts) then
      return
    end
  end
  require("lspconfig")[server].setup(server_opts)
end

local mlsp = require("mason-lspconfig")
mlsp.setup({ ensure_installed = { "lua_ls", "jsonls", "solargraph" } })
mlsp.setup_handlers({ setup_handler })
