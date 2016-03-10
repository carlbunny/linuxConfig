" vimrc fold
set fdm=marker  

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

call pathogen#infect() 

if isdirectory($ADMIN_SCRIPTS)
  source $ADMIN_SCRIPTS/master.vimrc
  "source $ADMIN_SCRIPTS/vim/biggrep.vim
  " Have more control over what plugins get loaded
  "  set runtimepath-=$ADMIN_SCRIPTS/vim
endif

" compiler
if executable("buck")
  compiler buck
endif

"copy to tmux
set clipboard=unnamed

set wildmode=longest,list,full
set wildmenu

" Vim setting {{{

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Enable mouse, not working in mosh now
set mouse=a

set history=10000

" keep going up a dir until you find a tags file
set tags=tags;/

set nu
set ruler
syntax enable

"indent
"search help for cinoptions-values

set autoindent
" It will increase the indent in a new block.
set smartindent

set expandtab
set shiftwidth=2
set softtabstop=2

set cinoptions+=g1,h1,N0,i4

" }}}
"
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'

" Autocommands {{{

" change cursor line color  while in insert mode {{{ 
augroup hi_CursorLine
  autocmd!
  autocmd InsertLeave * hi CursorLine ctermbg=17 "ctermfg=white blue
  autocmd InsertEnter * hi CursorLine ctermbg=233 "ctermfg=white grep
augroup END

" Save on FocusLost
au FocusLost * :silent! wall " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

" Disable paste mode when leaving Insert Mode
au InsertLeave * set nopaste

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Resize splits when the window is resized
au VimResized * :wincmd =

" max 80 column (Use ColorColumn to show inserting window {{{
augroup BgHighlight
  autocmd!
  autocmd WinEnter,VimEnter * set colorcolumn=80
  autocmd WinLeave * set colorcolumn=0
augroup END
hi ColorColumn ctermbg=darkYellow ctermfg=white guibg=darkblue guifg=white
" }}}

" }}}

" Vim UI {{{
hi Visual cterm=NONE ctermbg=darkGrey ctermfg=white

set cursorline
hi CursorLine cterm=NONE ctermbg=17 "ctermfg=white blue


" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" }}}


hi clear Search
hi clear IncSearch 
hi Search guifg=#ffffff guibg=#0000ff gui=none ctermfg=black  ctermbg=white 
hi IncSearch guifg=#ffffff guibg=#8888ff gui=none ctermfg=black  ctermbg=white 

" }}}

" key map========== {{{

"Map jj to escape
inoremap jj <Esc>
inoremap kk <Esc>

" Easy buffer navigation {{{
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" }}}

" don`t copy the replaced word into the paste buffer
vnoremap p "_dP

nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

noremap <F3> :set nu!<CR><CR>
map <F5> :set spell! spelllang=en_us<CR>
map <F6> :set ignorecase! <CR>
nnoremap <F7> :NERDTreeToggle<CR>
nmap <F8> :Tagbar<CR>
"set paste mode, will disable all the auto function in the view
set pastetoggle=<F9>

" }}}

" kill any trailing whitespace on save {{{
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
      \ autocmd BufWritePre  <buffer>
      \ :call <SID>StripTrailingWhitespaces()
" }}}

" File type mapping {{{
 filetype on
 au BufNewFile,BufRead *.tw set filetype=python
 au BufNewFile,BufRead *.thrift set filetype=cpp
 au BufNewFile,BufRead TARGETS set filetype=python
 au BufNewFile,BufRead *.cconf set filetype=python


" }}}

" color========== {{{
" vimdiff color {{{
highlight DiffAdd    cterm=bold ctermbg=22 " Green
highlight DiffDelete cterm=bold ctermbg=52 " Red
highlight DiffChange cterm=bold ctermbg=17 " Blue
highlight DiffText   cterm=bold ctermbg=18
" }}}
" }}}

" plugins=========  {{{
" tagbar {{{
  autocmd WinEnter,VimEnter, BufEnter  * nested :call tagbar#autoopen(1)
" }}}

"fugitive {{{
set statusline+={fugitive#statusline()}
" }}}

"vim-cpp-enhanced-highlight {{{
let g:cpp_class_scope_highlight = 1
" }}}

" unit {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <space> [unite]

nnoremap <silent> [unite]s  :Unite -start-insert file_rec/async<cr>
nnoremap <silent> [unite]b  :<C-u>Unite -start-insert -buffer-name=files buffer file <CR>
nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir -start-insert
      \ -buffer-name=files -prompt=%\  buffer file file_mru<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
      \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]ma
      \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
      \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
"grep and find in current vim dir
nnoremap [unite]f :UniteWithInput grep:.<cr>
nnoremap [unite]g :UniteWithCursorWord grep:.<cr>
"grep in current file
nnoremap [unite]k :UniteWithInput grep:%<cr>
nnoremap [unite]l :UniteWithCursorWord grep:%<cr>
"grep in the current bufer dir
nnoremap [unite]/ :UniteWithInput grep:<C-R>=expand("%:p:h")<CR><CR>
nnoremap [unite]* :UniteWithCursorWord grep:<C-R>=expand("%:p:h")<CR><CR>

"Tab
nnoremap [unite]t :Unite tab<cr>
"Resume
nnoremap [unite]r :UniteResume<cr>
"Window
nnoremap [unite]w :Unite window<cr>
"Jump
nnoremap [unite]j :Unite jump<cr>
"Changes
nnoremap [unite]c :Unite change<cr>
"Register
nnoremap [unite]u :Unite -buffer-name=register register<CR>
"Yank
nnoremap [unite]y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>

let g:unite_enable_short_source_names = 1

" To track long mru history.
let g:unite_source_file_mru_long_limit = 3000
let g:unite_source_directory_mru_long_limit = 3000

" Prompt choices.
let g:unite_prompt = '» '

" open preview vertically
let g:unite_kind_file_vertical_preview = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-p>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> lc     unite#do_action('lcd')
  nnoremap <silent><buffer><expr> c     unite#do_action('cd')
  nnoremap <silent><buffer><expr> u     unite#do_action('rec_parent')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ?
        \ ['sorter_reverse'] : [])

" why we have two for each line is because
" noremap is in normal mode(normal,visual,operator pending) 
" inoremap is in insert mode

  noremap <silent><buffer><expr> <C-s>     unite#do_action('split')
  inoremap <silent><buffer><expr> <C-s>     unite#do_action('split')
  noremap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')
  inoremap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')
  noremap <silent><buffer><expr> <C-t>     unite#do_action('tabopen')
  inoremap <silent><buffer><expr> <C-t>     unite#do_action('tabopen')
endfunction"}}}

let g:unite_source_file_mru_limit = 200

" For optimize.
let g:unite_source_file_mru_filename_format = ''

" For ack.
"if executable('ack')
  "let g:unite_source_grep_command = 'ack'
  "let g:unite_source_grep_default_opts = '--no-heading --no-color -a -H'
  "let g:unite_source_grep_recursive_opt = ''
"endif

" }}}

"airline {{{
"  variable names                default contents
"  ----------------------------------------------------------------------------
"  let g:airline_section_a       (mode, paste, iminsert)
"  let g:airline_section_b       (hunks, branch)
"  let g:airline_section_c       (bufferline or filename)
"  let g:airline_section_gutter  (readonly, csv)
"  let g:airline_section_x       (tagbar, filetype, virtualenv)
"  let g:airline_section_y       (fileencoding, fileformat)
"  let g:airline_section_z       (percentage, line number, column number)
"  let g:airline_section_warning (syntastic, whitespace)

" control which sections get truncated and at what width. 
let g:airline#extensions#default#section_truncate_width = { 
  \ 'b': 80, 
  \ 'x': 120,
  \ 'y': 250,
  \ 'z': 60,
  \ 'warning': 200, 
  \ }

" }}}

" tab line {{{

hi TabLine      ctermfg=Black  ctermbg=DarkGreen     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" }}}

" YCM {{{
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_confirm_extra_conf = 0 "disable annomying "ycm_extra_conf.py. Load?" popup everytime

let g:ycm_show_diagnostics_ui =0 "disable syntax check
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!'
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1
" using tag in ycm
" let g:ycm_collect_identifiers_from_tags_files = 0 

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

" YCM forceComple on save
"autocmd FileType c, h, cpp, python
      "\ autocmd BufWritePost * YcmForceCompileAndDiagnostics 
" }}}

"autoformat {{{
let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = " --style=google --indent=spaces=2 --pad-oper --pad-header --indent-modifiers --attach-classes --indent-col1-comments --max-instatement-indent="
" }}}

" }}}
