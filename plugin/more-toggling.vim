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
        setlocal formatoptions-=mB
        echom ":setlocal formatoptions-=mB"
    else
        setlocal formatoptions+=mB
        echom ":setlocal formatoptions+=mB"
    endif
endfunction
" This is chosen to work as in vim-unimpaired. I should add the on and off
" versions as well at some point.
nnoremap com :call ToggleMultibyte()<CR>
nnoremap [om :setlocal formatoptions+=mB<CR>
nnoremap ]om :setlocal formatoptions-=mB<CR>
