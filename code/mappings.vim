"let mapleader = "\<space>"
" meus atalhos de teclado
nnoremap <leader>; A;<esc>
nnoremap <leader>ec :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>we :vsplit <cr>
nnoremap <leader>ws :split <cr>
nnoremap <leader>sc :source ~/.config/nvim/init.vim<cr>
nnoremap <Leader>q :Bdelete<CR>
  "commentary
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

nmap <space>x <C-Y>,
" nav files

" set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
" Run the current file with rspec
 " map <Leader>rb :call VimuxRunCommand("clear; nvim " . bufname("%"))<CR>

 " " Prompt for a command to run
 " map <Leader>vp :VimuxPromptCommand<CR>

 " " Run last command executed by VimuxRunCommand
 " map <Leader>vl :VimuxRunLastCommand<CR>

 " " Inspect runner pane
 " map <Leader>vi :VimuxInspectRunner<CR>

 " " Close vim tmux runner opened by VimuxRunCommand
 " map <Leader>vq :VimuxCloseRunner<CR>

 " " Interrupt any command running in the runner pane
 " map <Leader>vx :VimuxInterruptRunner<CR>

 " " Zoom the runner pane (use <bind-key> z to restore runner pane)
 " map <Leader>vz :call VimuxZoomRunner()<CR>

 " " Clear the terminal screen of the runner pane.
 " map <Leader>v<C-l> VimuxClearTerminalScreen<CR>

" function! VimuxSlime()
 "  call VimuxRunCommand(@v, 0)
 " endfunction

 " " If text is selected, save it in the v buffer and send that buffer it to tmux
 " vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>

" " ruby {{
 "  nnoremap <F6> :AsyncRun -mode=term -pos=bottom -rows=20 rspec \| more <CR>
 "  nnoremap <F5> :AsyncRun -mode=term -pos=bottom -rows=10 ruby "$(VIM_FILEPATH)"<CR>
 "  nnoremap <F7> :AsyncRun -mode=term -pos=bottom -rows=10 node "$(VIM_FILEPATH)"<CR>
 "  nnoremap <F9> :AsyncRun -mode=term -pos=bottom -rows=10 g++ -o exec "$(VIM_FILEPATH)" && ./exec<CR>
 "  nnoremap <F10> :AsyncRun -mode=term -pos=bottom -rows=10 g++ -o exec "$(VIM_FILEPATH)"<CR>
 "  nnoremap <F4> :VimuxOpenRunner<CR>
 "  nnoremap <F3> :AsyncRun -mode=term -pos=bottom -rows=10 git add . && git commit -am "Solution" && git push origin master<CR>
 "  nnoremap <F2> :AsyncRun -mode=term -pos=bottom -rows=10 bin/setup<CR>
" " }}

" alternate way to save
nnoremap <c-s> :w<cr>
" Use alt + hjkl to resize windows
" Escape redraws the screen and removes any search highlighting.
nnoremap <esc> :noh<return><esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
nnoremap <M-TAB> :tabn<CR>
" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation


" Map Ctrl-Backspace to delete the previous word in insert mode.
    inoremap jk <esc>

    " shortcut to save
    nmap <leader>, :w<cr>

    " set paste toggle
    set pastetoggle=<leader>v

    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
    " edit gitconfig
    map <leader>eg :e! ~/.gitconfig<cr>

    " clear highlighted search
    "noremap <space> :set hlsearch! hlsearch?<cr>

    " activate spell-checking alternatives


    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    nmap <leader>l :set list!<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>


    nmap <leader>z <Plug>Zoom




    map <leader>wc :wincmd q<cr>

    " move line mappings
    " ∆ is <A-j> on macOS
    " ˚ is <A-k> on macOS
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    " open current buffer in a new tab
    nmap <silent> <M-'> :tab sb<cr>
    nmap <silent> <M-esc> :tabclose<cr>
    nmap <silent> <M-1> :tabprevious<cr>
    nmap <silent> <M-2> :tabfirst<cr>
    nmap <silent> <M-3> :tablast<cr>
    
" }}}
