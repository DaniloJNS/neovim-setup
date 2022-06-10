" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Show color in buffer
    Plug 'ap/vim-css-color'

    " Color scheme
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

    " Help insert documentation
    Plug 'danymat/neogen'

    " Gitbug copilot
    Plug 'github/copilot.vim'
    imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true

    " A personal wiki for vim
    Plug 'vimwiki/vimwiki'
    " For metrics of code
    Plug 'wakatime/vim-wakatime'

    " Doc in neovim
    Plug 'KabbAmine/zeavim.vim'

    " Git visualizatiion
    Plug 'kdheepak/lazygit.nvim'
    
    " Help indentation
    Plug 'Yggdroot/indentLine'

    " motion {
        Plug 'justinmk/vim-sneak'
        map m <Plug>Sneak_;
        Plug 'easymotion/vim-easymotion'
      " }
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " Maneger tabs and buffers
    Plug 'vim-ctrlspace/vim-ctrlspace'
    let g:CtrlSpaceDefaultMappingKey = "<C-space> "
    nnoremap <silent><M-o> :CtrlSpace O<CR>

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

    " Comment stuff out
    Plug 'tpope/vim-commentary'
    
    " Dracula theme
    Plug 'dracula/vim', { 'as': 'dracula' }

    " Set root directory properly
    Plug 'airblade/vim-rooter'

    " Git in the gutter
    Plug 'mhinz/vim-signify'

    " Tags
    Plug 'preservim/tagbar'

    " Discord
    Plug 'vimsence/vimsence'
    let g:vimsence_small_text = 'NeoVim'
    let g:vimsence_small_image = 'neovim'
    let g:vimsence_file_explorer_text = 'In NERDTree'
    let g:vimsence_file_explorer_details = 'Looking for files'

    " tree-sitter {{
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    "}}
    "
    " dev-icons
    Plug 'kyazdani42/nvim-web-devicons'

    " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'romgrk/fzy-lua-native'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " lsp stuff
    Plug 'neovim/nvim-lspconfig' 
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'RishabhRD/popfix'
    Plug 'RishabhRD/nvim-lsputils'    

    " snippets
    Plug 'hrsh7th/vim-vsnip'

    " Run Async terminal commands
    Plug 'skywind3000/asyncrun.vim'

    " multiple cursors with visual mode
    Plug 'terryma/vim-multiple-cursors'

    " File explorer
    Plug 'preservim/nerdtree' 
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'PhilRunninger/nerdtree-visual-selection'

    " Load colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'joshdick/onedark.vim'
" }}}

" General Functionality {{{
    " better terminal integration
    Plug 'akinsho/toggleterm.nvim'
    nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'

    " substitute, search, and abbreviate multiple variants of a word
    Plug 'tpope/vim-abolish'

    " easy commenting motions
    Plug 'tpope/vim-commentary'

    " mappings which are simply short normal mode aliases for commonly used ex commands
    Plug 'tpope/vim-unimpaired'

    " endings for html, xml, etc. - ehances surround
    Plug 'tpope/vim-ragtag'

    " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
    Plug 'tpope/vim-surround'

    " tmux integration for vim
    Plug 'preservim/vimux'

    " enables repeating other supported plugins with the . command
    Plug 'tpope/vim-repeat'

    " .editorconfig support
    Plug 'editorconfig/editorconfig-vim'

    " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    Plug 'AndrewRadev/splitjoin.vim'

    " detect indent style (tabs vs. spaces)
    Plug 'tpope/vim-sleuth'

    " Startify: Fancy startup screen for vim {{{
      Plug 'mhinz/vim-startify'
    " }}}

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>d :Bdelete<cr>
    " Writing in vim {{{{
        Plug 'junegunn/goyo.vim'

        autocmd! User GoyoEnter nested call helpers#goyo#enter()
        autocmd! User GoyoLeave nested call helpers#goyo#leave()
    " }}}
    "
    " context-aware pasting
    Plug 'sickill/vim-pasta'

    " FZF {{{
        Plug $HOMEBREW_PREFIX . '/opt/fzf'
        Plug 'junegunn/fzf.vim'
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        nmap <silent> <leader>gs :Git<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :G blame<cr>
        nmap <silent><leader>gd :Gvdiffsplit<cr>
        nmap <silent><leader>gf :Flog<cr>

        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'sodapopcan/vim-twiggy'
        Plug 'rbong/vim-flog'
        Plug 'junegunn/gv.vim'
    " }}}

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
        Plug 'quangnguyen30192/cmp-nvim-ultisnips' " For cmp engine
        Plug 'honza/vim-snippets'
        let g:UltiSnipsExpandTrigger="<C-l>"
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
        let g:UltiSnipsEditSplit="vertical"
        let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
        noremap<leader>sn :UltiSnipsEdit<cr>
    " }}}


" Language-Specific Configuration {{{
    " html / templates {{{
        " emmet support for vim - easily create markdup wth CSS-like syntax
        Plug 'mattn/emmet-vim'

        " match tags in html, similar to paren support
        Plug 'gregsexton/MatchTag', { 'for': 'html' }

        " html5 support
        Plug 'othree/html5.vim', { 'for': 'html' }

        " mustache support
        Plug 'mustache/vim-mustache-handlebars'

        " pug / jade support
        Plug 'digitaltoad/vim-pug', { 'for': ['jade', 'pug'] }

        " nunjucks support
        Plug 'niftylettuce/vim-jinja'

        " liquid support
        Plug 'tpope/vim-liquid'
    " }}}

    " JavaScript {{{
        Plug 'othree/yajs.vim', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
        Plug 'MaxMEllon/vim-jsx-pretty'
        let g:vim_jsx_pretty_highlight_close_tag = 1
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
    " }}}


    " Styles {{{
        Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        Plug 'groenewege/vim-less', { 'for': 'less' }
        Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
        Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
        Plug 'stephenway/postcss.vim', { 'for': 'css' }
    " " }}}

    " markdown {{{
        Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]

        " Open markdown files in Marked.app - mapped to <leader>m
        Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
        nmap <leader>m :MarkedOpen!<cr>
        nmap <leader>mq :MarkedQuit<cr>
        nmap <leader>* *<c-o>:%s///gn<cr>
    " }}}

    " JSON {{{
        Plug 'elzr/vim-json', { 'for': 'json' }
       let g:vim_json_syntax_conceal = 0
    " }}}

    Plug 'ekalinin/Dockerfile.vim'
    Plug 'jparise/vim-graphql'
" }}}
call plug#end()
