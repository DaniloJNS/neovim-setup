" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
" Don't change to directory when selecting a file
let g:startify_files_number = 5
let g:startify_change_to_dir = 0
let g:startify_custom_header = [ ]
let g:startify_relative_path = 1
let g:startify_use_env = 1

" Custom startup list, only show MRU from current directory/project
let g:startify_lists = [
\  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
\  { 'type': function('s:gitModified'),  'header': ['   git modified']},
\  { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
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
    \ { 'k': '~/.config/kitty/kitty.conf' },
    \ { 'f': '~/.config/fish/config.fish' },
    \ { 'z': '~/.zshrc' }
\ ]

let g:startify_custom_header =
       \ startify#pad(split(system('figlet -w 100 NVIM2022'), '\n'))

autocmd User Startified setlocal cursorline
nmap <leader>st :Startify<cr>
