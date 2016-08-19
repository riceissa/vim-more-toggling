function! ToggleSyntax()
    " See :help syntax for the code
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> coy :call ToggleSyntax()<CR>
nnoremap <silent> [oy :syntax enable<CR>
nnoremap <silent> ]oy :syntax off<CR>
" See also https://github.com/tpope/vim-unimpaired/pull/114/files which does
" buffer-local syntax toggling. It might make sense to defer to that and use
" [oY , ]oY , and coY here instead.

" Useful for when working with CJK files
function! ToggleMultibyte()
    if &formatoptions =~ 'm'
        setlocal formatoptions-=mB | setlocal spelllang-=cjk
        echom ":setlocal formatoptions-=mB | setlocal spelllang-=cjk"
    else
        setlocal formatoptions+=mB | setlocal spelllang+=cjk
        echom ":setlocal formatoptions+=mB | setlocal spelllang+=cjk"
    endif
endfunction
nnoremap com :call ToggleMultibyte()<CR>
nnoremap [om :setlocal formatoptions+=mB <Bar> setlocal spelllang+=cjk<CR>
nnoremap ]om :setlocal formatoptions-=mB <Bar> setlocal spelllang-=cjk<CR>

nnoremap <expr> cok &showbreak == '' ? ':set showbreak=\\<CR>' : ':set showbreak=<CR>'
nnoremap [ok :set showbreak=\\<CR>
nnoremap ]ok :set showbreak=<CR>
