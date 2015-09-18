set bg=dark
highlight NORMAL guibg=black guifg=white

augroup hi_CursorLine
  autocmd!
  autocmd InsertLeave * hi CursorLine guibg=#00005f 
  autocmd InsertEnter * hi CursorLine guibg=#121212f
augroup END

hi ColorColumn guibg=darkYellow guifg=white
hi Visual gui=NONE guibg=darkGrey guifg=white
hi CursorLine gui=NONE guibg=#00005f " Blue

hi Search guifg=black  guibg=white 
hi IncSearch guifg=black  guibg=white 

" vimdiff color {{{
highlight DiffAdd    gui=bold guibg=#005f00 " green
highlight DiffDelete gui=bold guibg=#5f0000 " Red
highlight DiffChange gui=bold guibg=#00005f " Blue
highlight DiffText   gui=bold guibg=#000087
" }}}

" tab line {{{

hi TabLine      guifg=Black  guibg=DarkGreen gui=NONE
hi TabLineFill  guifg=Black  guibg=Green     gui=NONE
hi TabLineSel   guifg=White  guibg=DarkBlue  gui=NONE

" }}}

