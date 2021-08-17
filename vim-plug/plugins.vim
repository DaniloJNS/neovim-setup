" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " git buffer
    Plug 'jreybert/vimagit'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Airline
    Plug 'vim-airline/vim-airline'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Top buffer/tab line
    Plug 'akinsho/nvim-bufferline.lua'
    " Comment stuff out
    Plug 'tpope/vim-commentary'
    " Dracula
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Set root directory properly
    Plug 'airblade/vim-rooter'
    " Git in the gutter
    Plug 'mhinz/vim-signify'
    " Tags
    Plug 'preservim/tagbar'
    nmap  <F8> : TagbarToggle <CR>
    " Discord
    Plug 'vimsence/vimsence'
    " tree-sitter {{
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
      "}}
    " dev-icons
    Plug 'kyazdani42/nvim-web-devicons'
    " " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'romgrk/fzy-lua-native'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " lsp stuff
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'hrsh7th/nvim-compe'
    " Plug 'RishabhRD/popfix'
    " Plug 'RishabhRD/nvim-lsputils'    
    " snippets
    Plug 'hrsh7th/vim-vsnip'


    Plug 'skywind3000/asyncrun.vim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'terryma/vim-multiple-cursors'
    Plug 'google/vim-maktaba'
    Plug 'scrooloose/nerdtree'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
    Plug 'yuezk/vim-js'
    " Plug 'preservim/nerdtree' 
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    " Plug 'ryanoasis/vim-devicons'
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'scrooloose/nerdtree-project-plugin'
    " Plug 'PhilRunninger/nerdtree-visual-selection'
    " Load colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'joshdick/onedark.vim'
  
    " LightLine {{{
        Plug 'itchyny/lightline.vim'
        Plug 'nicknisi/vim-base16-lightline'
        let g:lightline = {
            \   'colorscheme': 'base16',
            \   'active': {
            \       'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch' ],
            \               [ 'readonly', 'filetype', 'filename' ]],
            \       'right': [ [ 'percent' ], [ 'lineinfo' ],
            \               [ 'fileformat', 'fileencoding' ],
            \               [ 'gitblame', 'currentfunction',  'cocstatus', 'linter_errors', 'linter_warnings' ]]
            \   },
            \   'component_expand': {
            \   },
            \   'component_type': {
            \       'readonly': 'error',
            \       'linter_warnings': 'warning',
            \       'linter_errors': 'error'
            \   },
            \   'component_function': {
            \       'fileencoding': 'helpers#lightline#fileEncoding',
            \       'filename': 'helpers#lightline#fileName',
            \       'fileformat': 'helpers#lightline#fileFormat',
            \       'filetype': 'helpers#lightline#fileType',
            \       'gitbranch': 'helpers#lightline#gitBranch',
            \       'cocstatus': 'coc#status',
            \       'currentfunction': 'helpers#lightline#currentFunction',
            \       'gitblame': 'helpers#lightline#gitBlame'
            \   },
            \   'tab_component_function': {
            \       'filetype': 'helpers#lightline#tabFileType'
            \   },
            \   'tabline': {
            \       'left': [ [ 'tabs' ] ],
            \       'right': [ [ 'close' ] ]
            \   },
            \   'tab': {
            \       'active': [ 'filetype', 'filename', 'modified' ],
            \       'inactive': [ 'filetype', 'filename', 'modified' ],
            \   },
            \   'separator': { 'left': '', 'right': '' },
            \   'subseparator': { 'left': '', 'right': '' }
        \ }
    " }}}
" AutoGroups {{{
    " file type specific settings
    augroup configgroup
        autocmd!

        " automatically resize panes on resize
        autocmd VimResized * exe 'normal! \<c-w>='
        autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
        autocmd BufWritePost .vimrc.local source %
        " save all files on focus lost, ignoring warnings about untitled buffers
        autocmd FocusLost * silent! wa

        " make quickfix windows take all the lower section of the screen
        " when there are multiple windows open
        autocmd FileType qf wincmd J
        autocmd FileType qf nmap <buffer> q :q<cr>
    augroup END
" }}}
" }}}
" General Functionality {{{
    " better terminal integration
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

        " Don't change to directory when selecting a file
        let g:startify_files_number = 5
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': function('helpers#startify#listcommits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \   { 'uc': [ 'Update CoC Plugins', ':CocUpdate' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '~/.config/nvim/init.vim' },
            \ { 'g': '~/.gitconfig' },
            \ { 'z': '~/.zshrc' }
        \ ]

        autocmd User Startified setlocal cursorline
        nmap <leader>st :Startify<cr>
    " }}}

    " Close buffers but keep splits
    Plug 'moll/vim-bbye'
    nmap <leader>d :Bdelete<cr>
    " Writing in vim {{{{
        Plug 'junegunn/goyo.vim'

        autocmd! User GoyoEnter nested call helpers#goyo#enter()
        autocmd! User GoyoLeave nested call helpers#goyo#leave()
    " }}}
    " context-aware pasting
    Plug 'sickill/vim-pasta'
" FZF {{{
        Plug $HOMEBREW_PREFIX . '/opt/fzf'
        Plug 'junegunn/fzf.vim'

        if isdirectory(".git")
            " if in a git project, use :GFiles
            nmap <silent> <leader>t :GitFiles --cached --others --exclude-standard<cr>
        else
            " otherwise, use :FZF
            nmap <silent> <leader>t :FZF<cr>
        endif

        nmap <silent> <leader>s :GFiles?<cr>

        nmap <silent> <leader>r :Buffers<cr>
        nmap <silent> <leader>e :FZF<cr>
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)
        nnoremap <silent> <Leader>C :call fzf#run({
        \   'source':
        \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
        \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
        \   'sink':    'colo',
        \   'options': '+m',
        \   'left':    30
        \ })<CR>

        command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

        command! -bang -nargs=* Find call fzf#vim#grep(
            \ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>.' || true', 1,
            \ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
        " command! -bang -nargs=? -complete=dir Files
            " \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        command! -bang -nargs=? -complete=dir GitFiles
            \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
        function! RipgrepFzf(query, fullscreen)
            let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
            let initial_command = printf(command_fmt, shellescape(a:query))
            let reload_command = printf(command_fmt, '{q}')
            let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
            call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
        endfunction

        function! FloatingFZF()
            let buf = nvim_create_buf(v:true, v:true)
            let height = float2nr(&lines * 0.5)
            let width = float2nr(&columns * 0.7)
            let horizontal = float2nr((&columns - width) / 2)
            let vertical = 0
            let opts = {
                \ 'relative': 'editor',
                \ 'row': vertical,
                \ 'col': horizontal,
                \ 'width': width,
                \ 'height': height,
                \ 'style': 'minimal'
            \ }
            call nvim_open_win(buf, v:true, opts)
        endfunction

        let $FZF_DEFAULT_OPTS= $FZF_DEFAULT_OPTS
            \ . " --layout reverse"
            \ . " --pointer ' '"
            \ . " --info hidden"
            \ . " --color 'bg+:0'"
            \ . " --border rounded"

        let g:fzf_preview_window = ['right:50%:hidden', '?']
        let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    " }}}

    " vim-fugitive {{{
        Plug 'tpope/vim-fugitive'
        nmap <silent> <leader>gs :Git<cr>
        nmap <leader>ge :Gedit<cr>
        nmap <silent><leader>gr :Gread<cr>
        nmap <silent><leader>gb :G blame<cr>

        Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'sodapopcan/vim-twiggy'
        Plug 'rbong/vim-flog'
    " }}}

    " UltiSnips {{{
        Plug 'SirVer/ultisnips' " Snippets plugin
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
        " Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
        Plug 'moll/vim-node', { 'for': 'javascript' }
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
        Plug 'MaxMEllon/vim-jsx-pretty'
        let g:vim_jsx_pretty_highlight_close_tag = 1
    " }}}

    " TypeScript {{{
        Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
        " Plug 'Shougo/vimproc.vim', { 'do': 'make' } TODO what still needs this?
    " }}}


    " Styles {{{
        " Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
        " Plug 'groenewege/vim-less', { 'for': 'less' }
        " Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
        " Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
        " Plug 'stephenway/postcss.vim', { 'for': 'css' }
    " " }}}

    " markdown {{{
        " Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        " let g:markdown_fenced_languages = [ 'tsx=typescript.tsx' ]

        " " Open markdown files in Marked.app - mapped to <leader>m
        " Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
        " nmap <leader>m :MarkedOpen!<cr>
        " nmap <leader>mq :MarkedQuit<cr>
        " nmap <leader>* *<c-o>:%s///gn<cr>
    " }}}

    " JSON {{{
        Plug 'elzr/vim-json', { 'for': 'json' }
        let g:vim_json_syntax_conceal = 0
    " }}}

    Plug 'ekalinin/Dockerfile.vim'
    Plug 'jparise/vim-graphql'
" }}}


call plug#end()
