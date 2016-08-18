function! ToggleSyntax()
    " See :h syntax for the code
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> coy :call ToggleSyntax()<CR>

" Useful for when working with Japanese files
function! ToggleMultibyte()
    if &formatoptions =~ 'm'
        setlocal formatoptions-=mB
        echom "formatoptions-=mB"
    else
        setlocal formatoptions+=mB
        echom "formatoptions+=mB"
    endif
endfunction
" This is chosen to work as in vim-unimpaired. I should add the on and off
" versions as well at some point.
nnoremap com :call ToggleMultibyte()<CR>
