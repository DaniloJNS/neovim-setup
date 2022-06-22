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
nnoremap <c-o> :NERDTreeToggle<cr>
"nnoremap <c-p> :files<cr>
nmap <C-p> :RnvimrToggle<CR>

"Zeal Mappings
nmap <leader>z <Plug>Zeavim
vmap <leader>z <Plug>ZVVisSelection
nmap gz <Plug>ZVOperator
nmap <leader><leader>z <Plug>ZVKeyDocset
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
" Run the current file with rspec

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" Clear the terminal screen of the runner pane.
map <Leader>v<C-l> VimuxClearTerminalScreen<CR>

vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>

"" ruby {{
 nnoremap <F6> :AsyncRun -mode=term -pos=bottom -rows=30 ruby "$(VIM_FILEPATH)"<CR>
 map <Leader>rb :AsyncRun -mode=term -pos=bottom -rows=30 rspec "$(VIM_FILEPATH)"\| more <CR>
 map <Leader>rs :AsyncRun -mode=term -pos=bottom -rows=30 docker-compose exec web bash -c "rspec"\| more <CR>
 nnoremap <F5> :AsyncRun -mode=term -pos=bottom -rows=30 rspec \| more <CR>
 nnoremap <F4> :AsyncRun -mode=term -pos=bottom -rows=30 rubocop<CR>
 map <Leader>rp :AsyncRun -mode=term -pos=bottom -rows=30 rubocop "$(VIM_FILEPATH)"\| more <CR>
 map <Leader>rc :AsyncRun -mode=term -pos=bottom -rows=30 rubocop -A "$(VIM_FILEPATH)"\| more <CR>
 map <Leader>rl :AsyncRun -mode=term -pos=bottom -rows=30 rails runner "$(VIM_FILEPATH)"\| more <CR>
"" }}

nnoremap <F10> :AsyncRun -mode=term -pos=bottom -rows=10 g++ -o exec "$(VIM_FILEPATH)" && ./exec<CR>
nnoremap <F9> :AsyncRun -mode=term -pos=bottom -rows=10 gcc -o exec "$(VIM_FILEPATH)" && ./exec<CR>
nnoremap <Leader>mk :AsyncRun -mode=term -pos=bottom -rows=10 make main<CR>
nnoremap <F7> :AsyncRun -mode=term -pos=bottom -rows=10 node "$(VIM_FILEPATH)"<CR>
nnoremap <F3> :VimuxOpenRunner<CR>
nnoremap <F2> :AsyncRun -mode=term -pos=bottom -rows=10 bin/setup<CR>
nnoremap <leader>go :AsyncRun -mode=term -pos=bottom -rows=10 go run "$(VIM_FILEPATH)"<CR>
"" alternate way to save
nnoremap <c-s> :w<cr>
"" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
" Escape redraws the screen and removes any search highlighting.
nnoremap <esc> :noh<return><esc>
nnoremap <M-r>    zR
nnoremap <M-m>    zM
nnoremap <M-a>    zA
" folder close and up
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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" General Mappings {{{
"    " set a map leader for more key combos

"    " edit ~/.config/nvim/init.vim
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>
     " edit gitconfig
    map <leader>eg :e! ~/.gitconfig<cr>

"    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

"    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

"    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " Close windown but keep buffer
    map <leader>wc :wincmd q<cr>

"    " toggle cursor line 
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

"    " moving up and down work as you would expect
    nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <silent> <expr> ^ (v:count == 0 ? 'g^' :  '^')
    nnoremap <silent> <expr> $ (v:count == 0 ? 'g$' : '$')

    " open current buffer in a new tab
    nmap <silent> <M-'> :tab sb<cr>
    nmap <silent> <M-esc> :tabclose<cr>
    nmap <silent> <M-1> :tabprevious<cr>
    nmap <silent> <M-2> :tabfirst<cr>
    nmap <silent> <M-3> :tablast<cr>
    
"" }}}
