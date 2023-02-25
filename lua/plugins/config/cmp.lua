local cmp = require("cmp")
local T = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
cmp.setup({
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      -- require("luasnip").lsp_expand(args.body)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<TAB>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif require("luasnip").jumpable(1) then
        --   return T("<Plug>(luasnip-expand-or-jump)")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif require("luasnip").jumpable(-1) then
        --   return T("<Plug>(luasnip-jump-prev)")
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "luasnip" },
    { name = "ultisnips" }, -- For ultisnips users.
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = function(_, item)
      local icon = neovim.get_icon("cmp", item.kind)
      if icon then
        item.kind = icon .. item.kind
      end
      return item
    end,
  },
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
})
