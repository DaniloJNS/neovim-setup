-- This file is automatically loaded by lazyvim.plugins.config

local maps = { i = {}, n = {}, v = {}, x = {}, o = {}, s = {}, t = {} }
-- fast config
maps.n["<leader>ec"] = { "<cmd>vsplit ~/.config/nvim/init.lua<cr>", desc = "jump for root file config" }
-- better up/down
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true }

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

-- Move Lines
maps.n["<A-n>"] = { ":m .+1<cr>==", desc = "Move down" }
maps.i["<A-n>"] = { "<Esc>:m .+1<cr>==gi", desc = "Move down" }
maps.v["<A-n>"] = { ":m '>+1<cr>gv=gv", desc = "Move down" }
maps.n["<A-m>"] = { ":m .-2<cr>==", desc = "Move up" }
maps.v["<A-m>"] = { ":m '<-2<cr>gv=gv", desc = "Move up" }
maps.i["<A-m>"] = { "<Esc>:m .-2<cr>==gi", desc = "Move up" }

-- manager windows
maps.n["<leader>ww"] = { "<C-W>p", desc = "Other window" }
maps.n["<leader>wc"] = { "<C-W>c", desc = "Delete window" }
maps.n["<leader>ws"] = { "<C-W>s", desc = "Split window below" }
maps.n["<leader>we"] = { "<C-W>v", desc = "Split window right" }
maps.n["<leader>-"] = { "<C-W>s", desc = "Split window below" }
maps.n["<leader>|"] = { "<C-W>v", desc = "Split window right" }

-- tabs
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
-- -- -- JSON FORMATTERS
maps.n["<leader>js"] = { "<cmd>%!python -m json.tool<cr>", desc = "Formatter json file" }

-- buffers
if neovim.has("bufferline.nvim") then
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" }
  maps.n["<TAB>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" }
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

-- Clear search with <esc>
maps.i["<esc>"] = { "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch" }
maps.n["<esc>"] = { "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch" }

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
maps.n["<leader>ur"] = {
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  desc = "Redraw / clear hlsearch / diff update",
}
--
maps.n["gw"] = { "*N" }
maps.x["gw"] = { "*N" }

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
maps.n["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
maps.x["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
maps.o["n"] = { "'Nn'[v:searchforward]", expr = true, desc = "Next search result" }
maps.n["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
maps.x["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }
maps.o["N"] = { "'nN'[v:searchforward]", expr = true, desc = "Prev search result" }

-- Add undo break-points
maps.i[","] = { ",<c-g>u" }
maps.i["."] = { ".<c-g>u" }
maps.i[";"] = { ";<c-g>u" }
--
-- save file
maps.i["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
maps.v["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
maps.n["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }
maps.s["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" }

-- better indenting
maps.v["<"] = { "<gv" }
maps.v[">"] = { ">gv" }

-- lazy
maps.n["<leader>l"] = { "<cmd>:Lazy<cr>", desc = "Lazy" }

-- new file
maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }

maps.n["<leader>xl"] = { "<cmd>lopen<cr>", desc = "Open Location List" }
maps.n["<leader>xq"] = { "<cmd>copen<cr>", desc = "Open Quickfix List" }

-- stylua: ignore start

-- toggle options
maps.n["<leader>uf"] = { require("plugins.lsp.format").toggle, desc = "Toggle format on Save" }
maps.n["<leader>us"] = { function() neovim.toggle_opt("spell") end, desc = "Toggle Spelling" }
maps.n["<leader>uw"] = { function() neovim.toggle_opt("wrap") end, desc = "Toggle Word Wrap" }
maps.n["<leader>ul"] = { function()
  neovim.toggle_opt("relativenumber", true)
  neovim.toggle_opt("number")
end, desc = "Toggle Line Numbers" }
maps.n["<leader>ud"] = { neovim.toggle_diagnostics, desc = "Toggle Diagnostics" }
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
maps.n["<leader>uc"] = { function() neovim.toggle_opt("conceallevel", false, { 0, conceallevel }) end
  , desc = "Toggle Conceal" }

-- lazygit
maps.n["<leader>gg"] = { function() neovim.float_term({ "lazygit" }, { cwd = neovim.get_root() }) end
  , desc = "Lazygit (root dir)" }
maps.n["<leader>gG"] = { function() neovim.float_term({ "lazygit" }) end, desc = "Lazygit (cwd)" }

-- quit
maps.n["<leader>qq"] = { "<cmd>qa<cr>", desc = "Quit all" }
maps.n["Q"] = { "<cmd>qa<cr>", desc = "Quit all" }
maps.n["qq"] = { "<cmd>bd<cr>", desc = "Quit all" }

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  maps.n["<leader>ui"] = { vim.show_pos, desc = "Inspect Pos" }
end

-- floating terminal
maps.n["<leader>ft"] = { function() neovim.float_term(nil, { cwd = neovim.get_root() }) end,
  desc = "Terminal (root dir)" }
maps.n["<leader>fT"] = { function() neovim.float_term() end, desc = "Terminal (cwd)" }
maps.t["<esc><esc>"] = { "<c-\\><c-n>", desc = "Enter Normal Mode" }

-- windows
neovim.set_mappings(maps)
