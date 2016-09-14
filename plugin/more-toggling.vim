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
  if &formatoptions =~# 'm'
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

function! TextwidthOn(default_tw, count)
  if a:count > 0
    exe 'setlocal textwidth=' . a:count
    echom ':setlocal textwidth=' . a:count
  elseif &textwidth > 0
    exe 'setlocal textwidth=' . &textwidth
    echom ":setlocal textwidth=" . &textwidth
  elseif exists('b:save_tw')
    exe 'setlocal textwidth=' . b:save_tw
    echom ":setlocal textwidth=" . b:save_tw
  else
    exe 'setlocal textwidth=' . a:default_tw
    echom ":setlocal textwidth=" . a:default_tw
  endif
endfunction

function! TextwidthOff()
  if &textwidth > 0
    let b:save_tw = &textwidth
  endif
  exe 'setlocal textwidth=0'
  echom ":setlocal textwidth=0"
endfunction

function! ToggleTextwidth(default_tw, count)
  if &textwidth > 0
    call TextwidthOff(a:default_tw)
  else
    call TextwidthOn(a:default_tw, a:count)
  endif
endfunction

nnoremap cot :<C-U>call ToggleTextwidth(79, v:count)<CR>
nnoremap [ot :<C-U>call TextwidthOn(79, v:count)<CR>
nnoremap ]ot :<C-U>call TextwidthOff()<CR>
