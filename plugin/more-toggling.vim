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

nnoremap [ot :<C-U>setlocal textwidth=<C-R>=v:count > 0
      \ ? v:count
      \ : &textwidth > 0
      \         ? &textwidth
      \         : exists("b:tw_saved") && b:tw_saved > 0
      \                 ? b:tw_saved
      \                 : 79<CR> <Bar> let b:tw_saved = &textwidth<CR>

nnoremap ]ot :<C-U>setlocal textwidth=0 <Bar> let b:tw_saved=<C-R>=v:count > 0
      \ ? v:count
      \ : &textwidth > 0
      \         ? &textwidth
      \         : exists("b:tw_saved") && b:tw_saved > 0
      \                 ? b:tw_saved
      \                 : 79<CR><CR>

nmap <expr> cot &textwidth == 0 ? '[ot' : ']ot'
