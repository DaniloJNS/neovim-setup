-- This file is automatically loaded by plugins.config

vim.opt.shortmess:append({ s = true, I = true }) -- disable startup message
vim.opt.shortmess:append({ W = true, I = true, c = true })

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

neovim.vim_opts({
  opt = {
    autowrite = true, -- Enable auto write
    backspace = vim.opt.backspace + { "nostop" }, -- Don't stop backspace at insert
    clipboard = "unnamedplus", -- Connection to the system clipboard
    cmdheight = 0, -- hide command line unless needed
    completeopt = { "menuone", "noselect" }, -- Options for insert mode completion
    conceallevel = 3, -- Hide * markup for bold and italic
    confirm = true, -- Confirm to save changes before exiting modified buffer
    copyindent = true, -- Copy the previous indentation on autoindenting
    cursorline = true, -- Enable highlighting of the current line
    expandtab = true, -- Use spaces instead of tabs
    fileencoding = "utf-8", -- File content encoding for the buffer
    fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
    formatoptions = "jcroqlnt", -- tcqj
    grepformat = "%f:%l:%c:%m", --
    grepprg = "rg, --vimgrep", --
    guifont = "FiraCodeNerdFontMono", --
    history = 100, -- Number of commands to remember in a history table
    ignorecase = true, -- Case insensitive searching
    inccommand = "nosplit", -- preview incremental substitute
    laststatus = 3, -- globalstatus
    list = true, -- Show some invisible characters (tabs...
    listchars = "tab:→ ,eol:↴,trail:⋅,extends:❯,precedes:❮",
    mouse = "a", -- Enable mouse support
    number = true, -- Show numberline
    preserveindent = true, -- Preserve indent structure as much as possible
    pumblend = 10, -- Popup blend
    pumheight = 10, -- Height of the pop up menu
    relativenumber = true, -- Show relative numberline
    scrolloff = 99999, -- Number of lines to keep above and below the cursor
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
    shiftround = true, -- Keep cursor in middle screen
    shiftwidth = 2, -- Number of space inserted for indentation
    showmode = false, -- Disable showing modes in command line
    showtabline = 2, -- always display tabline
    sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
    signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true, -- Case sensitivie searching
    smartindent = true, -- Insert indents automatically
    spelllang = { "en" }, --
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    tabstop = 2, -- Number of spaces tabs count for
    termguicolors = true, -- Enable 24-bit RGB color in the TUI
    timeoutlen = 300, -- Length of time to wait for a mapped sequence
    undofile = true, -- Enable persistent undo
    undolevels = 10000, --
    updatetime = 200, -- Save swap file and trigger CursorHold
    wildmode = "longest:full,full", -- Command-line completion mode
    winminwidth = 5, -- Minimum window width
    wrap = false, -- Disable wrapping of lines longer than the width of window
    writebackup = false, -- Disable making a backup before overwriting a file
  },
  g = {
    mapleader = " ",
    maplocalleader = " ",
    markdown_recommended_style = 0, -- Fix markdown indentation settings
    diagnostics_enabled = true, -- enable diagnostics at start
    status_diagnostics_enabled = true,
  },
})
