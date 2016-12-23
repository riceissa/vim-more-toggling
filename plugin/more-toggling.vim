if exists('g:loaded_more_toggling')
  finish
endif
let g:loaded_more_toggling = 1

nnoremap [oY :syntax enable<CR>
nnoremap ]oY :syntax off<CR>
nnoremap coY :<C-R>=exists("g:syntax_on") ? 'syntax off' : 'syntax enable'<CR><CR>

" From https://github.com/tpope/vim-unimpaired/pull/114/files which does
" buffer-local syntax toggling.
nnoremap [oy :setlocal syntax=ON<CR>
nnoremap ]oy :setlocal syntax=OFF<CR>
nnoremap coy :setlocal syntax=<C-R>=&l:syntax ==# 'OFF' ? 'ON' : 'OFF'<CR><CR>

" Useful for when working with CJK files
nnoremap [om :setlocal formatoptions+=mB spelllang+=cjk<CR>
nnoremap ]om :setlocal formatoptions-=mB spelllang-=cjk<CR>
nnoremap com :setlocal <C-R>=(&formatoptions =~# 'm') ? 'formatoptions-=mB spelllang-=cjk' : 'formatoptions+=mB spelllang+=cjk'<CR><CR>

nnoremap [ok :set showbreak=\\<CR>
nnoremap ]ok :set showbreak=<CR>
nnoremap cok :set showbreak=<C-R>=(&showbreak == '') ? '\\' : ''<CR><CR>

" nnoremap [ot :setlocal textwidth=<C-R>=b:save_tw<CR><CR>
" nnoremap ]ot :setlocal textwidth=0<C-R>=&textwidth > 0 <Bar><Bar> (exists("b:save_tw") && b:save_tw > 0) ? ' <Bar> let b:save_tw = ' . &textwidth : ' <Bar> let b:save_tw = 79'<CR><CR>

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

nnoremap [ot :setlocal textwidth=<C-R>=v:count > 0
      \ ? v:count
      \ : &textwidth > 0
      \         ? &textwidth
      \         : exists("b:save_tw")
      \                 ? b:save_tw
      \                 : 79<CR><CR>

nnoremap ]ot :setlocal textwidth=0 <Bar> let b:save_tw=<C-R>=&textwidth > 0
      \ ? &textwidth
      \ : exists("b:save_tw") && b:save_tw > 0
      \         ? b:save_tw
      \         : 79<CR><CR>

function! ToggleTextwidth(default_tw, count)
  if &textwidth > 0
    call TextwidthOff()
  else
    call TextwidthOn(a:default_tw, a:count)
  endif
endfunction

" nnoremap cot :<C-U>call ToggleTextwidth(79, v:count)<CR>
" nnoremap [ot :<C-U>call TextwidthOn(79, v:count)<CR>
" nnoremap ]ot :<C-U>call TextwidthOff()<CR>
