" vimrc fold
set fdm=marker  

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

call pathogen#infect() 

"copy to tmux
set clipboard=unnamed

set wildmode=longest,list,full
set wildmenu

" + and - to resize window
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>


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
set tags=./.tags;,.tags

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

" color scheme
colorscheme anotherdark
set background=dark

" Autocommands {{{

" change cursor line color  while in insert mode {{{ 
augroup hi_CursorLine
  autocmd!
  autocmd InsertLeave * hi CursorLine ctermbg=17 "ctermfg=white blue
  autocmd InsertEnter * hi CursorLine ctermbg=233 "ctermfg=white grep
augroup END

" Save on FocusLost
"au FocusLost * :silent! wall " Save on FocusLost
"au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

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
"inoremap kk <Esc>

" Easy buffer navigation {{{
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" }}}

" don`t copy the replaced word into the paste buffer
vnoremap p "_dP
" star key won't jump to the next
nnoremap * *#

nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

noremap <F3> :set nu!<CR><CR>
map <F5> :set spell! spelllang=en_us<CR>
map <F6> :set ignorecase! <CR>
nnoremap <F7> :NERDTreeToggle<CR>
nmap <F8> :Tagbar<CR>
" clang-format
map <F4> :py3f /usr/local/share/clang/clang-format.py<CR>
imap <F4> <ESC>:py3f /usr/local/share/clang/clang-format.py<CR>i
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
 au BufNewFile,BufRead *.cinc set filetype=python
 au BufNewFile,BufRead *.thrift set filetype=cpp
 au BufNewFile,BufRead TARGETS set filetype=python
 au BufNewFile,BufRead *.cconf set filetype=python


" }}}

" compiler
if executable('buck')
  compiler! buck
  autocmd FileType c,cpp compiler! buck
endif
let g:dispatch_quickfix_height=20
let g:dispatch_tmux_height=20
" color========== {{{
" vimdiff color {{{
"highlight DiffAdd    cterm=bold ctermbg=22 " Green
"highlight DiffDelete cterm=bold ctermbg=52 " Red
"highlight DiffChange cterm=bold ctermbg=17 " Blue
"highlight DiffText   cterm=bold ctermbg=18
" }}}
" }}}

" plugins=========  {{{
"fugitive {{{
set statusline+={fugitive#statusline()}
" }}}

"vim-cpp-enhanced-highlight {{{
let g:cpp_class_scope_highlight = 1
" }}}

"lightline {{{
" Show lightline when single buffer opened
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified', 'gutentags'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%#ModifiedColor#%{LightlineModified()}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \   'gutentags': '%{exists("*gutentags#statusline")?gutentags#statusline():""}',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())',
      \   'gutentags': '("" != gutentags#statusline())',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
function! LightlineModified()
      let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
      let mode = get(map, mode()[0], mode()[0])
      let bgcolor = {'n': [240, '#585858'], 'i': [31, '#0087af']}
      let color = get(bgcolor, mode, bgcolor.n)
      exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
      \ color[0], color[1])
      return &modified ? '+' : &modifiable ? '' : '-'
endfunction
"}}}

" Gutentags {{{
" fleet_coordinator is used to locate tape project
let g:gutentags_project_root = ['.root', 'if', '.git', '.hg', '.project', 'AUTODEPS']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/local/cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--python-kinds=-i']
let g:gutentags_ctags_extra_args += [
      \ '--langdef=thrift', 
      \ '--langmap=thrift:.thrift',
      \ '--regex-thrift=/^[ \t]*exception[ \t]+([a-zA-Z0-9_]+)/\1/x,exception/',
      \ '--regex-thrift=/^[ \t]*enum[ \t]+([a-zA-Z0-9_]+)/\1/e,enum`/',
      \ '--regex-thrift=/^[ \t]*struct[ \t]+([a-zA-Z0-9_]+)/\1/s,struct/',
      \ '--regex-thrift=/^[ \t]*service[ \t]+([a-zA-Z0-9_]+)/\1/v,service/',
      \ '--regex-thrift=/^[ \t]*[0-9]+:[ \t]+([a-zA-Z0-9_]+)[\t]+([a-zA-Z0-9_]+)/\2/m,member/',
      \ '--regex-thrift=/^[ \t]*([a-zA-Z0-9_]+)[ \t]+=/\1/a,value/',
      \ '--regex-thrift=/^[ \t]*[a-zA-Z0-9_<>]+[ \t]+([a-zA-Z0-9_]+)[ \t]*\(/\1/f,function/',
      \ '--langmap=python:+.cinc',
      \ '--langmap=python:+.cconf',
      \ '--langmap=python:+.mconf',
      \ '--langmap=python:+.tw',
      \ '--extra=+f'
      \ ]


" Enable more debugging stuff
let g:gutentags_define_advanced_commands = 1
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
" }}}

" denite {{{
  " The prefix key.
  nnoremap    [denite]   <Nop>
  nmap    <space> [denite]
  
	" Define mappings
	autocmd FileType denite call s:denite_my_settings()
	function! s:denite_my_settings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ denite#do_map('do_action')
	  nnoremap <silent><buffer><expr> d
	  \ denite#do_map('do_action', 'delete')
	  nnoremap <silent><buffer><expr> p
	  \ denite#do_map('do_action', 'preview')
	  nnoremap <silent><buffer><expr> q
	  \ denite#do_map('quit')
	  nnoremap <silent><buffer><expr> i
	  \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
	  \ denite#do_map('toggle_select').'j'
	  nnoremap <silent><buffer><expr> r
    \ denite#do_map('do_action', 'quickfix')
    nnoremap <silent><buffer><expr> <C-s>
    \ denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> <C-v>
    \ denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> <C-t>
    \ denite#do_map('do_action', 'tabopen')
  endfunction

	autocmd FileType denite-filter call s:denite_filter_my_settings()
	function! s:denite_filter_my_settings() abort
	  imap <silent><buffer> jj <Plug>(denite_filter_quit)
	endfunction

  nnoremap [denite]b :Denite buffer file file/rec -start-filter<cr>

  nnoremap [denite]d :DeniteBufferDir buffer file file/rec -start-filter<cr>
  nnoremap [denite]/ :DeniteBufferDir -start-filter grep:::!<CR>
  nnoremap [denite]* :DeniteBufferDir -buffer-name=grep -input=<C-R><C-W> grep:::!<cr>

  "AUTODEPS is used in the project
  nnoremap [denite]pd :DeniteProjectDir file/rec -root-markers='AUTODEPS' -start-filter<cr>
  nnoremap [denite]p* :DeniteProjectDir -buffer-name=grep -root-markers='AUTODEPS' -input=<C-R><C-W> grep:::!<cr>
  nnoremap [denite]p/ :DeniteProjectDir -buffer-name=grep -root-markers='AUTODEPS' -start-filter grep:::!<cr>

  nnoremap [denite]o :Denite outline<cr>
  nnoremap [denite]r :Denite -resume<cr>
  nnoremap [denite]j :Denite jump<cr>
  nnoremap [denite]u :Denite register<cr>
  
  "grep and find in current vim dir
  nnoremap [denite]f :Denite -start-filter grep:::!<cr>
  nnoremap [denite]g :DeniteCursorWord grep:.<cr>
  "grep in current file
  nnoremap [denite]k :Denite grep:%<cr>
  nnoremap [denite]l :DeniteCursorWord grep:%<cr>

	" Change file/rec command.
	call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

	" Change matchers.
	call denite#custom#source(
	\ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
  call denite#custom#source(
        \ 'file/rec', 'matchers', ['matcher/cpsm'])

  " Change sorters.
	call denite#custom#source(
	\ 'file/rec', 'sorters', ['sorter/sublime'])

	" Change default action.
	call denite#custom#kind('file', 'default_action', 'open')

	" Change ignore_globs
	call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
	      \ [ '.git/', '.ropeproject/', '__pycache__/',
	      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

  call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
  call denite#custom#option('_', 'highlight_matched_range', 'None')
  call denite#custom#option('_', 'highlight_matched_char', 'None')
" }}}

" }}}
