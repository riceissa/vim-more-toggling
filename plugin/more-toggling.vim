if exists('g:loaded_more_toggling')
  finish
endif
let g:loaded_more_toggling = 1

function! ToggleSyntax()
  " See :help syntax for the code
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction
nnoremap <silent> coY :call ToggleSyntax()<CR>
nnoremap <silent> [oY :syntax enable<CR>
nnoremap <silent> ]oY :syntax off<CR>
" From https://github.com/tpope/vim-unimpaired/pull/114/files which does
" buffer-local syntax toggling.
nnoremap [oy :setlocal syntax=ON<CR>
nnoremap ]oy :setlocal syntax=OFF<CR>
nnoremap coy :setlocal syntax=<C-R>=&l:syntax ==# 'OFF' ? 'ON' : 'OFF'<CR><CR>

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

function! ToggleTextwidth(default_tw)
  if &textwidth > 0
    let b:save_tw = &textwidth
    setlocal textwidth=0
    echom ":setlocal textwidth=0"
  else
    if !exists('b:save_tw')
      b:save_tw = a:default_tw
    endif
    exe 'setlocal textwidth=' . b:save_tw
    echom ":setlocal textwidth=" . b:save_tw
  endif
endfunction
nnoremap cot :call ToggleTextwidth(79)<CR>
