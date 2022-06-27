" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " UI {{
      " Color scheme {{
        Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
        Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'chriskempson/base16-vim'
        Plug 'joshdick/onedark.vim'
      " }}

      " dev-icons
        Plug 'kyazdani42/nvim-web-devicons'

      " Airline
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    " }}

    " File {{
      " Code General {{
        " lsp stuff
          Plug 'neovim/nvim-lspconfig' 
          Plug 'hrsh7th/cmp-nvim-lsp'
          Plug 'hrsh7th/cmp-buffer'
          Plug 'hrsh7th/cmp-path'
          Plug 'hrsh7th/cmp-cmdline'
          Plug 'hrsh7th/nvim-cmp'
          Plug 'petertriho/cmp-git' " Complete git infos
          " For developer plugins
            Plug 'RishabhRD/popfix'
          Plug 'RishabhRD/nvim-lsputils'
          Plug 'p00f/clangd_extensions.nvim'

        " Debugging
          Plug 'mfussenegger/nvim-dap'
          Plug 'rcarriga/nvim-dap-ui'
          Plug 'theHamsta/nvim-dap-virtual-text'

        " snippets
          Plug 'hrsh7th/vim-vsnip'
          Plug 'honza/vim-snippets'

        " UltiSnips {{{
            Plug 'SirVer/ultisnips' " Snippets plugin
            Plug 'quangnguyen30192/cmp-nvim-ultisnips' " For cmp engine
            let g:UltiSnipsExpandTrigger="<C-l>"
            let g:UltiSnipsJumpForwardTrigger="<C-j>"
            let g:UltiSnipsJumpBackwardTrigger="<C-k>"
            let g:UltiSnipsEditSplit="vertical"
            let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
            noremap<leader>sn :UltiSnipsEdit<cr>
        " }}}

        " Help insert documentation
          Plug 'danymat/neogen'

        " detect indent style (tabs vs. spaces)
          Plug 'tpope/vim-sleuth'

        " Tags
          Plug 'preservim/tagbar'

        " Help indentation
          Plug 'Yggdroot/indentLine'

        " Automations for edit {{
            Plug 'mg979/vim-visual-multi', {'branch': 'master'} 
          " Comment stuff out
            Plug 'tpope/vim-commentary'

          " Auto pairs for '(' '[' '{'
            Plug 'jiangmiao/auto-pairs'

          " multiple cursors with visual mode
            " Plug 'terryma/vim-multiple-cursors'

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

          " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
            Plug 'AndrewRadev/splitjoin.vim'
        " }}
      " }}

      " File explorer {{
        " Nerdtree {{
          Plug 'preservim/nerdtree' 
          Plug 'Xuyuanp/nerdtree-git-plugin'
          Plug 'ryanoasis/vim-devicons'
          Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
          Plug 'PhilRunninger/nerdtree-visual-selection'
        " }}

          " Ranger
            Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
       " }}

       " Sintax {{
         " Sintax highlight for many languages
           Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
       " }}
    " }}

    " Buffers and tabs {{
      " Maneger tabs and buffers
        Plug 'vim-ctrlspace/vim-ctrlspace'
        let g:CtrlSpaceDefaultMappingKey = "<C-space> "
        nnoremap <silent><M-o> :CtrlSpace O<CR>

        " Close buffers but keep splits
          Plug 'moll/vim-bbye'
          nmap <leader>d :Bdelete<cr>
        " Maximaze buffer
          Plug 'szw/vim-maximizer'
    " }}
    "
    " Git {{
      " Better visualization of diffs
        Plug 'sindrets/diffview.nvim'
      " Git visualizatiion
        Plug 'kdheepak/lazygit.nvim'

      " Git in the gutter
        Plug 'mhinz/vim-signify'

      " Github integration
        Plug 'pwntester/octo.nvim'

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
    " }}

    " Terminal integration {{
      " better terminal integration
        Plug 'akinsho/toggleterm.nvim'
        nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'

      " tmux integration for vim
        Plug 'preservim/vimux'

      " Run Async terminal commands
        Plug 'skywind3000/asyncrun.vim'
    " }}

    " Study {{
      " A personal wiki for vim
        Plug 'vimwiki/vimwiki'

      " Doc in neovim
        Plug 'KabbAmine/zeavim.vim'
    " }}

    " motion {
        Plug 'justinmk/vim-sneak'
        " map m <Plug>Sneak_;
        " Plug 'easymotion/vim-easymotion'
    " }

    " Set root directory properly
    Plug 'airblade/vim-rooter'

    " For metrics of code
    Plug 'wakatime/vim-wakatime'

    " Discord
    Plug 'vimsence/vimsence'
    let g:vimsence_small_text = 'NeoVim'
    let g:vimsence_small_image = 'neovim'
    let g:vimsence_file_explorer_text = 'In NERDTree'
    let g:vimsence_file_explorer_details = 'Looking for files'

    

" }}}

" General Functionality {{{
    " enables repeating other supported plugins with the . command
      Plug 'tpope/vim-repeat'

    " context-aware pasting
      Plug 'sickill/vim-pasta'

    " .editorconfig support
      Plug 'editorconfig/editorconfig-vim'

    " Startify: Fancy startup screen for vim {{{
      Plug 'mhinz/vim-startify'
    " }}}

    " Writing in vim {{{{
      Plug 'junegunn/goyo.vim'

      autocmd! User GoyoEnter nested call helpers#goyo#enter()
      autocmd! User GoyoLeave nested call helpers#goyo#leave()
    " }}}

    " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Telescope extensions {{
      Plug 'nvim-telescope/telescope-ui-select.nvim' 
      Plug 'romgrk/fzy-lua-native'
      Plug 'nvim-telescope/telescope-fzy-native.nvim'
      " Telescope Integetation with octo-github
        Plug 'nvim-telescope/telescope-github.nvim'
      " Create key-bindings and watch them with telescope
        Plug 'LinArcX/telescope-command-palette.nvim'
      " Cheatsheet plugin for neovim with Telescope as UI
        Plug 'sudormrfbin/cheatsheet.nvim'
    " }}

    " FZF {{{
        Plug $HOMEBREW_PREFIX . '/opt/fzf'
        Plug 'junegunn/fzf.vim'
    " }}}
" }}

" Language-Specific Configuration {{{
"   " fish scripting {{{
        Plug 'dag/vim-fish'
    " }}}
    "
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
        " Show color in buffer
        Plug 'ap/vim-css-color'
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
