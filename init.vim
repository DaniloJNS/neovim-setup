if exists('g:vscode')
    " VSCode extension
    source $HOME/.config/nvim/code/code.vim
else
 source $HOME/.config/nvim/smartquit.vim

" general
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
" source $HOME/.config/nvim/plug-config/signify.vim
source $HOME/.config/nvim/plug-config/nvim-tree.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/lazygit.vim

source $HOME/.config/nvim/plug-config/lsp-config.vim
source $HOME/.config/nvim/plug-config/searching.vim
" source $HOME/.config/nvim/plug-config/vimspect.vim
" lua
luafile $HOME/.config/nvim/plug-config/tree-sitter-config.lua
luafile $HOME/.config/nvim/plug-config/bufferline-config.lua
" luafile $HOME/.config/nvim/plug-config/lsps-config.lua
" luafile $HOME/.config/nvim/plug-config/compe-config.lua
luafile $HOME/.config/nvim/plug-config/telescope.lua

colorscheme dracula
set guifont=FiraCodeNerdFont
let g:neovide_transparency=1
endif

