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
" Tags NAV
nmap  <F8> : TagbarToggle <CR>

"Zeal Mappings
nmap <leader>z <Plug>Zeavim
vmap <leader>z <Plug>ZVVisSelection
nmap gz <Plug>ZVOperator
nmap <leader><leader>z <Plug>ZVKeyDocset
" set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
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

function! VimuxSlime()
  call VimuxRunCommand(@v, 0)
 endfunction

 " If text is selected, save it in the v buffer and send that buffer it to tmux
 vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>

 function Teste() 
  echo globpath('.', '*')
 endfunction
" ruby {{
  nnoremap <F6> :AsyncRun -mode=term -pos=bottom -rows=30 ruby "$(VIM_FILEPATH)"<CR>
  map <Leader>rb :AsyncRun -mode=term -pos=bottom -rows=30 rspec "$(VIM_FILEPATH)"\| more <CR>
  map <Leader>rs :AsyncRun -mode=term -pos=bottom -rows=30 docker-compose exec web bash -c "rspec"\| more <CR>
  nnoremap <F5> :AsyncRun -mode=term -pos=bottom -rows=30 rspec \| more <CR>
  nnoremap <F4> :AsyncRun -mode=term -pos=bottom -rows=30 rubocop<CR>
  map <Leader>rp :AsyncRun -mode=term -pos=bottom -rows=30 rubocop "$(VIM_FILEPATH)"\| more <CR>
  map <Leader>rc :AsyncRun -mode=term -pos=bottom -rows=30 rubocop -A "$(VIM_FILEPATH)"\| more <CR>
  map <Leader>rl :AsyncRun -mode=term -pos=bottom -rows=30 rails runner "$(VIM_FILEPATH)"\| more <CR>
" }}

nnoremap <F10> :AsyncRun -mode=term -pos=bottom -rows=10 g++ -o exec "$(VIM_FILEPATH)" && ./exec<CR>
nnoremap <F9> :AsyncRun -mode=term -pos=bottom -rows=10 gcc -lpthread -o exec "$(VIM_FILEPATH)" && ./exec<CR>
nnoremap <F7> :AsyncRun -mode=term -pos=bottom -rows=10 node "$(VIM_FILEPATH)"<CR>
nnoremap <F3> :VimuxOpenRunner<CR>
nnoremap <F2> :AsyncRun -mode=term -pos=bottom -rows=10 bin/setup<CR>
" alternate way to save
nnoremap <c-s> :w<cr>
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
" Escape redraws the screen and removes any search highlighting.
nnoremap <esc> :noh<return><esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
nnoremap <M-w> :tabn<CR>
" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Map Ctrl-Backspace to delete the previous word in insert mode.
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

" General Mappings {{{
    " set a map leader for more key combos


    " remap esc
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
    nmap ;s :set invspell spelllang=en<cr>

    " markdown to html
    nmap <leader>md :%!markdown --html4tags <cr>

    " remove extra whitespace
    nmap <leader><space> :%s/\s\+$<cr>
    nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

    inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

    nmap <leader>l :set list!<cr>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " switch between current and last buffer
    nmap <leader>. <c-^>

    " enable . command in visual mode
    vnoremap . :normal .<cr>

    map <leader>wc :wincmd q<cr>

    " move line mappings
    " ∆ is <A-j> on macOS
    " ˚ is <A-k> on macOS
    nnoremap ∆ :m .+1<cr>==
    nnoremap ˚ :m .-2<cr>==
    inoremap ∆ <Esc>:m .+1<cr>==gi
    inoremap ˚ <Esc>:m .-2<cr>==gi
    vnoremap ∆ :m >+1<cr>gv=gv
    vnoremap ˚ :m '<-2<cr>gv=gv

    vnoremap $( <esc>`>a)<esc>`<i(<esc>
    vnoremap $[ <esc>`>a]<esc>`<i[<esc>
    vnoremap ${ <esc>`>a}<esc>`<i{<esc>
    vnoremap $" <esc>`>a"<esc>`<i"<esc>
    vnoremap $' <esc>`>a'<esc>`<i'<esc>
    vnoremap $\ <esc>`>o*/<esc>`<O/*<esc>
    vnoremap $< <esc>`>a><esc>`<i<<esc>

    " toggle cursor line
    nnoremap <leader>i :set cursorline!<cr>

    " scroll the viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    " moving up and down work as you would expect
    nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <silent> <expr> ^ (v:count == 0 ? 'g^' :  '^')
    nnoremap <silent> <expr> $ (v:count == 0 ? 'g$' : '$')

    " helpers for dealing with other people's code
    nmap \t :set ts=4 sts=4 sw=4 noet<cr>
    nmap \s :set ts=4 sts=4 sw=4 et<cr>

    nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

    command! Rm call functions#Delete()
    command! RM call functions#Delete() <Bar> q!

    " Custom text objects

    " inner-line
    xnoremap <silent> il :<c-u>normal! g_v^<cr>
    onoremap <silent> il :<c-u>normal! g_v^<cr>

    " around line
    vnoremap <silent> al :<c-u>normal! $v0<cr>
    onoremap <silent> al :<c-u>normal! $v0<cr>

    " Interesting word mappings
    nmap <leader>0 <Plug>ClearInterestingWord
    nmap <leader>1 <Plug>HiInterestingWord1
    nmap <leader>2 <Plug>HiInterestingWord2
    nmap <leader>3 <Plug>HiInterestingWord3
    nmap <leader>4 <Plug>HiInterestingWord4
    nmap <leader>5 <Plug>HiInterestingWord5
    nmap <leader>6 <Plug>HiInterestingWord6

    " open current buffer in a new tab
    nmap <silent> <M-'> :tab sb<cr>
    nmap <silent> <M-esc> :tabclose<cr>
	nmap <silent> <M-1> :tabprevious<cr>
    nmap <silent> <M-2> :tabfirst<cr>
    nmap <silent> <M-3> :tablast<cr>
    
" }}}
