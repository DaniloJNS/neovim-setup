-- This file is automatically loaded by lazyvim.plugins.config

local maps = { i = {}, n = {}, v = {}, x = {}, o = {}, s = {}, t = {} }

-- Standard operations {{
  -- fast config
  maps.n["<leader>ec"] = { "<cmd>vsplit ~/.config/nvim/init.lua<cr>", desc = "jump for root file config" }
  -- quit commands
  maps.n["<leader>qq"] = { "<cmd>qa<cr>", desc = "Quit all" }
  maps.n["Q"] = { "<cmd>qa<cr>", desc = "Quit all" }
  maps.n["qq"] = { "<cmd>bd<cr>", desc = "Quit all" }
  maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
-- }}

-- File maneger {{
  -- save file
  maps.i["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
  maps.v["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
  maps.n["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
  maps.s["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
  -- new file
  maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
  if neovim.has("neo-tree.nvim") then
    maps.n["<leader>fe"] = {
      function()
        require("neo-tree.command").execute({ toggle = true, dir = neovim.get_root() })
      end,
      desc = "Explore NoTree(root dir)",
    }
    maps.n["<leader>fE"] = { "<cmd>Neotree toggle<CR>", desc = "Explorer NeoTree (cwd)" }
    maps.n["<leader>e"] = { "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true }
    maps.n["<C-o>"] = { "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true }
    maps.n["<leader>E"] = { "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true }
  end
  -- }}

-- improve coding experience {{
  -- better up/down
  maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true }
  maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true }

  -- Better move Lines
  maps.n["<A-n>"] = { ":m .+1<cr>==", desc = "Move down" }
  maps.i["<A-n>"] = { "<Esc>:m .+1<cr>==gi", desc = "Move down" }
  maps.v["<A-n>"] = { ":m '>+1<cr>gv=gv", desc = "Move down" }
  maps.n["<A-m>"] = { ":m .-2<cr>==", desc = "Move up" }
  maps.v["<A-m>"] = { ":m '<-2<cr>gv=gv", desc = "Move up" }
  maps.i["<A-m>"] = { "<Esc>:m .-2<cr>==gi", desc = "Move up" }

  -- Search result
  maps.n["gw"] = { "*N" }
  maps.x["gw"] = { "*N" }

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  maps.n["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
  maps.x["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
  maps.o["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
  maps.n["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
  maps.x["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
  maps.o["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }

  -- better indenting
  maps.v["<"] = { "<gv" }
  maps.v[">"] = { ">gv" }

  -- Clear search with <esc>
  maps.i["<esc>"] = { "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch" }
  maps.n["<esc>"] = { "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch" }

  -- Clear search, diff update and redraw
  -- taken from runtime/lua/_editor.lua
  maps.n["<leader>ur"] =
  { "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", desc = "Redraw / clear hlsearch / diff update" }

  if neovim.has("nvim-spectre") then
    maps.n["<leader>sr"] = { function() require("spectre").open() end, desc = "Replace in files (Spectre)" }
  end
-- }}


-- maneger tabs {{
  maps.n["<leader><tab>l"] = { "<cmd>tablast<cr>", desc = "Last Tab" }
  maps.n["<leader><tab>f"] = { "<cmd>tabfirst<cr>", desc = "First Tab" }
  maps.n["<leader><tab><tab>"] = { "<cmd>tabnew<cr>", desc = "New Tab" }
  maps.n["<leader><tab>]"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
  maps.n["<leader><tab>d"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }
  maps.n["<leader><tab>["] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
  -- my friendly tabs
  maps.n["<M-esc>"] = { "<cmd>tabclose<cr>", desc = "Close Tab" }
  maps.n["<M-'>"] = { "<cmd>tab sb<cr>", desc = "New Tab" }
  maps.n["<M-TAB>"] = { "<cmd>tabnext<cr>", desc = "Next Tab" }
  maps.n["<M-1>"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" }
-- }}

-- manager windows {{
  maps.n["<leader>ww"] = { "<C-W>p", desc = "Other window" }
  maps.n["<leader>wc"] = { "<C-W>c", desc = "Delete window" }
  maps.n["<leader>ws"] = { "<C-W>s", desc = "Split window below" }
  maps.n["<leader>we"] = { "<C-W>v", desc = "Split window right" }
  maps.n["<leader>-"] = { "<C-W>s", desc = "Split window below" }
  maps.n["<leader>|"] = { "<C-W>v", desc = "Split window right" }

  if neovim.has("smart-splits.nvim") then
    -- Better window navigation
    maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
    maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
    maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
    maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }

    -- Resize window using <alt> arrow keys
    maps.n["<A-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
    maps.n["<A-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
    maps.n["<A-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
    maps.n["<A-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
  else
    -- Move to window using the <ctrl> hjkl keys
    maps.n["<C-h>"] = { "<C-w>h", desc = "Go to left window" }
    maps.n["<C-j>"] = { "<C-w>j", desc = "Go to lower window" }
    maps.n["<C-k>"] = { "<C-w>k", desc = "Go to upper window" }
    maps.n["<C-l>"] = { "<C-w>l", desc = "Go to right window" }
    -- Resize window using <alt> arrow keys
    maps.n["<A-k>"] = { "<cmd>resize +2<cr>", desc = "Increase window height" }
    maps.n["<A-j>"] = { "<cmd>resize -2<cr>", desc = "Decrease window height" }
    maps.n["<A-h>"] = { "<cmd>vertical resize -2<cr>", desc = "Decrease window width" }
    maps.n["<A-l>"] = { "<cmd>vertical resize +2<cr>", desc = "Increase window width" }
  end
-- }}

-- maneger buffers {{
  if neovim.has("bufferline.nvim") then
    maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
    maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
    maps.n["<TAB>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
    maps.n["<S-TAB>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
    maps.n["[b"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
    maps.n["]b"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  else
    maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
    maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
    maps.n["<TAB>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
    maps.n["[b"] = { "<cmd>bprevious<cr>", desc = "Prev buffer" }
    maps.n["]b"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  end
  maps.n["<leader>bb"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }
  maps.n["<leader>`"] = { "<cmd>e #<cr>", desc = "Switch to Other Buffer" }

-- Delete buffers
  if neovim.has("mini.bufremove") then
    maps.n["<leader>bd"] = { function() require("mini.bufremove").delete(0, false) end, desc = "Close buffer" }
    maps.n["<leader>bD"] = { function() require("mini.bufremove").delete(0, true) end, desc = "Force close buffer" }
  else
    maps.n["<leader>c"] = { "<cmd>bdelete<cr>", desc = "Close buffer" }
    maps.n["<leader>C"] = { "<cmd>bdelete!<cr>", desc = "Force close buffer" }
  end
-- }}

-- Notation maneger {{
  if neovim.has("todo-comments") then
    maps.n["]t"] = { function() require("todo-comments").jump_next() end, desc = "Next todo comment" }
    maps.n["[t"] = { function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" }
    maps.n["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" }
    maps.n["<leader>xT"] = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" }
    maps.n["<leader>st"] = { "<cmd>TodoTelescope<cr>", desc = "Todo" }
  end
  -- better writer docs
  if neovim.has("neogen") then
    maps.n["<Leader>nf"] = { function() require("neogen").generate({ snippet_engine = "luasnip" }) end, desc = "Insert notation for function" }
    maps.n["<Leader>nc"] = { function() require("neogen").generate({ snippet_engine = "luasnip", type = "class" }) end, desc = "Insert notation for class" }
  end
-- }}

-- LSP {{
  if neovim.has("trouble") then
    maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
    maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
  end
  -- code inforamtions
    maps.i["<M-k>"] = { function () vim.lsp.signature_help() end, desc = "signature_help" }
    maps.i["<c-k>"] = { vim.lsp.buf.signature_help, desc = "Signature Help" }
    maps.n["gk"] = { vim.lsp.buf.signature_help, desc = "signature_help" }
    maps.n["K"] = {  vim.lsp.buf.hover, desc = "Hover" }
  -- search code operations
    maps.n["gr"] = { require("navigator.reference").async_ref, desc = "async_ref" }
    maps.n["<Leader>gr"] = { require("navigator.reference").reference, desc = "reference" } -- reference deprecated
    maps.n["gd"] = { require("navigator.definition").definition, desc = "definition" }
    maps.n["<Space>D"] = { vim.lsp.buf.type_definition, desc = "type_definition" }
    maps.n["gp"] = { require("navigator.definition").definition_preview, desc = "definition_preview" }
    maps.n["gD"] = { vim.lsp.buf.declaration, desc = "declaration" }
    maps.n["gi"] = { vim.lsp.buf.implementation, desc = "implementation" }
    maps.n["<Leader>gi"] = { vim.lsp.buf.incoming_calls, desc = "incoming_calls" }
    maps.n["<Leader>go"] = { vim.lsp.buf.outgoing_calls, desc = "outgoing_calls" }
  -- Symbols
    maps.n["g0"] = { require("navigator.symbols").document_symbols, desc = "document_symbols" }
    maps.n["gW"] = { require("navigator.workspace").workspace_symbol_live, desc = "workspace_symbol_live" }
    maps.n["<Leader>gt"] = { require("navigator.treesitter").buf_ts, desc = "buf_ts" }
    maps.n["<Leader>gT"] = { require("navigator.treesitter").bufs_ts, desc = "bufs_ts" }
    maps.n["<Leader>ct"] = { require("navigator.ctags").ctags, desc = "ctags" }
  -- Diagnostics
    maps.n["gL"] = { require("navigator.diagnostics").show_diagnostics, desc = "show_diagnostics" }
    maps.n["gG"] = { require("navigator.diagnostics").show_buf_diagnostics, desc = "show_buf_diagnostics" }
    maps.n["]d"] = { vim.diagnostic.goto_next, desc = "next diagnostics" }
    maps.n["[d"] = { vim.diagnostic.goto_prev, desc = "prev diagnostics" }
    maps.n["]O"] = { function () vim.diagnostic.set_loclist() end, desc = "diagnostics set loclist" }
  -- code providers
    maps.n["<Space>cr"] =   {require("navigator.rename").rename, desc = "rename" }
    maps.n["<Space>ca"] = { require("navigator.codeAction").code_action, desc = "code_action" }
    maps.v["<Space>ca"] = { require("navigator.codeAction").range_code_action, desc = "range_code_action" }
    maps.n["<Space>cl"] =  { require("navigator.codelens").run_action, desc = "run code lens action" }
    maps.n["<Space>cf"] = { vim.lsp.buf.format, desc = "format" }
    maps.n["<Space>cf"] = { vim.lsp.buf.range_formatting, desc = "range format" }
    -- JSON FORMATTERS
      maps.n["<leader>js"] = { "<cmd>%!python -m json.tool<cr>", desc = "Formatter json file" }
  -- Telescope providers 
    if neovim.has('telescope') then
      maps.n["<Space>cgd"] = { "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" }
      maps.n["<Space>cgr"] = { "<cmd>Telescope lsp_references<cr>", desc = "References" }
      maps.n["<Space>cgI"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" }
      maps.n["<Space>cgt"] = { "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" }
    end
-- }}

-- DAP {{
-- Add undo break-points
  maps.i[","] = { ",<c-g>u" }
  maps.i["."] = { ".<c-g>u" }
  maps.i[";"] = { ";<c-g>u" }
-- }}

-- lazy comands {{
  maps.n["<leader>l"] = { "<cmd>:Lazy<cr>", desc = "Lazy" }
-- }}

-- maneger lists {{
  maps.n["<leader>xl"] = { "<cmd>lopen<cr>", desc = "Open Location List" }
  maps.n["<leader>xq"] = { "<cmd>copen<cr>", desc = "Open Quickfix List" }
-- }}

-- toggle options {{
  maps.n["<leader>uf"] = { require("plugins.lsp.format").toggle, desc = "Toggle format on Save" }
  maps.n["<leader>us"] = { function() neovim.toggle_opt("spell") end, desc = "Toggle Spelling" }
  maps.n["<leader>uw"] = { function() neovim.toggle_opt("wrap") end, desc = "Toggle Word Wrap" }
  maps.n["<leader>ul"] = { function() neovim.toggle_opt("relativenumber", true); neovim.toggle_opt("number") end, desc = "Toggle Line Numbers" }
  maps.n["<leader>ud"] = { neovim.toggle_diagnostics, desc = "Toggle Diagnostics" }
  local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
  maps.n["<leader>uc"] = { function() neovim.toggle_opt("conceallevel", false, { 0, conceallevel }) end, desc = "Toggle Conceal" }
-- }}

-- Terminal commands {{
  maps.n["<leader>gg"] = { function() neovim.float_term({ "lazygit" }, { cwd = neovim.get_root() }) end, desc = "Lazygit (root dir)" }
  maps.n["<leader>gG"] = { function() neovim.float_term({ "lazygit" }) end, desc = "Lazygit (cwd)", }
  -- floating terminal; 
  maps.n["<leader>ft"] = { function() neovim.float_term(nil, { cwd = neovim.get_root() }) end, desc = "Terminal (root dir)", }
  maps.n["<leader>fT"] = { function() neovim.float_term() end, desc = "Terminal (cwd)", }
  maps.t["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter Normal Mode" }
-- }}
-- highlights under cursor; 
if vim.fn.has("nvim-0.9.0") == 1 then
  maps.n["<leader>ui"] = { vim.show_pos, desc = "Inspect Pos" }
end

neovim.set_mappings(maps)
