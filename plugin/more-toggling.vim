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

function! ToggleTextwidth(default_tw)
  if &textwidth > 0
    let b:save_tw = &textwidth
    setlocal textwidth=0
    echom ":setlocal textwidth=0"
  else
    " Actually v:count should probably override even if b:save_tw doesn't
    " exist.
    if !exists('b:save_tw')
      if v:count > 0
        b:save_tw = v:count
      else
        b:save_tw = a:default_tw
      endif
    endif
    exe 'setlocal textwidth=' . b:save_tw
    echom ":setlocal textwidth=" . b:save_tw
  endif
endfunction
" TODO add maps for [ot and ]ot
nnoremap cot :call ToggleTextwidth(79)<CR>

" Sample usage
"       ]ot     turn tw=0
"       80]ot   no range allowed when turning off
"       [ot     turn tw on, to saved value, or if none, then 79
"       80[ot   turn tw=80
"       cot     toggle tw, so on to saved value or 79 if off, and to 0 if on
"
" What should be the value of 'textwidth' after the following sequences? Each
" arrow "->" below separates a command. So ":set tw=72 -> cot" means a
" ":set tw=72" command followed by a "cot" in normal mode, not the
" command-line mode command ":set tw=72 -> cot", which would result in
" an error.
"       :set tw=72 -> 80[ot				80
"       :set tw=72 -> cot -> cot			72
"       :set tw=0 -> cot				79
"       :set tw=72 -> cot -> 80cot			80
"       " Doing 80cot doesn't make sense if a count is given, so it acts
"       " like 80[ot instead.
"       :set tw=0 -> cot -> 80cot			80
"       :set tw=72 -> :set tw=0 -> cot			79
"       :set tw=72 -> ]ot -> cot			72
"       :set tw=0 -> [ot -> 
"       :set tw=0 -> 72[ot -> :set tw=0 -> cot		79 or 72?
"       :
