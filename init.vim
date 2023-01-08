if exists('g:vscode')
    " VSCode extension
    source $HOME/.config/nvim/code/code.vim
else

     source $HOME/.config/nvim/smartquit.vim

    " general
    source $HOME/.config/nvim/general/settings.vim
    source $HOME/.config/nvim/keys/mappings.vim

    " Plugins config
    source $HOME/.config/nvim/vim-plug/plugins.vim
    source $HOME/.config/nvim/plug-config/airline.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/vim-commentary.vim
    source $HOME/.config/nvim/plug-config/nvim-tree.vim
    source $HOME/.config/nvim/plug-config/lazygit.vim
    " source $HOME/.config/nvim/plug-config/searching.vim
    source $HOME/.config/nvim/plug-config/startify.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    " lua
    " luafile $HOME/.config/nvim/lua/config/general/settings.lua
    luafile $HOME/.config/nvim/plug-config/tree-sitter-config.lua
    luafile $HOME/.config/nvim/plug-config/cmp.lua
    luafile $HOME/.config/nvim/plug-config/cmp_git.lua
    luafile $HOME/.config/nvim/plug-config/lsps-config.lua
    luafile $HOME/.config/nvim/plug-config/nvim_lsp_jdtls.lua
    luafile $HOME/.config/nvim/plug-config/dap.lua
    luafile $HOME/.config/nvim/plug-config/telescope.lua
    luafile $HOME/.config/nvim/plug-config/dressing.lua
    luafile $HOME/.config/nvim/plug-config/toggleterm.lua
    luafile $HOME/.config/nvim/plug-config/tokyonight.lua
    luafile $HOME/.config/nvim/plug-config/octo.lua
    luafile $HOME/.config/nvim/plug-config/diffview.lua
    luafile $HOME/.config/nvim/plug-config/trouble.lua
    luafile $HOME/.config/nvim/plug-config/lsp-colors.lua
    luafile $HOME/.config/nvim/plug-config/indent-blankline.lua
    luafile $HOME/.config/nvim/plug-config/scroll-bar.lua
    luafile $HOME/.config/nvim/plug-config/gitsigns.lua
    luafile $HOME/.config/nvim/plug-config/symbols-outline.lua
    luafile $HOME/.config/nvim/plug-config/haskell-tool.lua
    luafile $HOME/.config/nvim/lua/init.lua
endif
