source $HOME/.config/nvim/code/keymapping/tabs.vim
source $HOME/.config/nvim/code/keymapping/file.vim


let g:mapleader = "\<Space>"

function! s:split(...) abort
    let direction = a:1
    let file = exists('a:2') ? a:2 : ''
    call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if !empty(file)
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
endfunction

function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, empty(file) ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
    call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorHeight(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewHeight' : 'workbench.action.decreaseViewHeight')
    endfor
endfunction

function! s:manageEditorWidth(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewWidth' : 'workbench.action.decreaseViewWidth')
    endfor
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
command! -bang Only if <q-bang> ==# '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

AlterCommand sp[lit] Split
AlterCommand vs[plit] Vsplit
AlterCommand new New
AlterCommand vne[w] Vnew
AlterCommand on[ly] Only
xnoremap <leader>c <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>
nnoremap <leader>c <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>

" window navigation
nnoremap <leader>s <Cmd>call <SID>split('h')<CR>
xnoremap <leader>s <Cmd>call <SID>split('h')<CR>

nnoremap <leader>e <Cmd>call <SID>split('v')<CR>
xnoremap <leader>e <Cmd>call <SID>split('v')<CR>

" window maneger size
nnoremap <M-k> <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
xnoremap <M-k> <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
nnoremap <M-j> <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
xnoremap <M-j> <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
nnoremap <M-l> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
xnoremap <M-l> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
nnoremap <M-h> <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>
xnoremap <M-h> <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>
