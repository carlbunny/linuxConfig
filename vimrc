source $ADMIN_SCRIPTS/master.vimrc

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

set history=10000

set nu
set ruler
syntax enable

"indent
"search help for cinoptions-values
set cinoptions+=g1,h1,N0,i4

"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'

"noremap <F3> :Autoformat<CR><CR>
map <F5> :set spell! spelllang=en_us<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <F7> :NERDTreeToggle<CR>
"set paste mode, will disable all the auto function in the view
set pastetoggle=<F9>

hi Visual cterm=NONE ctermbg=darkGrey ctermfg=white

set cursorline
hi CursorLine cterm=NONE ctermbg=17 "ctermfg=white blue
" make status line red while in insert mode
augroup hi_CursorLine
  autocmd!
  autocmd InsertLeave * hi CursorLine ctermbg=17 "ctermfg=white blue
  autocmd InsertEnter * hi CursorLine ctermbg=236 "ctermfg=white grep
" autocmd InsertEnter * hi CursorLine ctermbg=52 "ctermfg=white red
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

" max 80 column
augroup BgHighlight
    autocmd!
    autocmd WinEnter,VimEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END
hi ColorColumn ctermbg=darkYellow ctermfg=white guibg=darkblue guifg=white

nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

hi clear Search
hi clear IncSearch 
hi Search guifg=#ffffff guibg=#0000ff gui=none ctermfg=black  ctermbg=white 
hi IncSearch guifg=#ffffff guibg=#8888ff gui=none ctermfg=black  ctermbg=white 

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" kill any trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
 
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text
  \ autocmd BufWritePre <buffer>
  \ :call <SID>StripTrailingWhitespaces()

"vimdiff color
highlight DiffAdd    cterm=bold ctermfg=White ctermbg=DarkGreen
highlight DiffDelete cterm=bold ctermfg=White ctermbg=DarkRed
highlight DiffChange cterm=bold ctermfg=White ctermbg=DarkCyan
highlight DiffText   cterm=bold ctermfg=Yellow ctermbg=DarkCyan


"plugins===============================================================================
"fugitive
set statusline+=%{fugitive#statusline()}

" unit
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <space> [unite]

nnoremap <C-p> :Unite -start-insert file_rec/async<cr>
nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
      \ -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
      \ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]r  :<C-u>Unite
      \ -buffer-name=register register<CR>
nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [unite]f
      \ :<C-u>Unite -buffer-name=resume resume<CR>
nnoremap <silent> [unite]d
      \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]ma
      \ :<C-u>Unite mapping<CR>
nnoremap <silent> [unite]me
      \ :<C-u>Unite output:message<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
"mimic grep and find
nnoremap [unite]/ :Unite -start-insert grep:.<cr>
nnoremap [unite]* :UniteWithCursorWord grep:.<cr>
"Resume
nnoremap [unite]r :UniteResume<cr>
"Yank
nnoremap [unite]y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"Search
nnoremap <silent> [unite]s
      \ :<C-u>Unite -buffer-name=files -no-split -start-insert
      \ jump_point file_point buffer_tab
      \ file_rec:! file file/new file_mru<CR>

let g:unite_enable_short_source_names = 1

" To track long mru history.
let g:unite_source_file_mru_long_limit = 3000
let g:unite_source_directory_mru_long_limit = 3000

" Prompt choices.
let g:unite_prompt = '» '

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
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ?
        \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction"}}}

let g:unite_source_file_mru_limit = 200

" For optimize.
let g:unite_source_file_mru_filename_format = ''

" For ack.
if executable('ack')
   let g:unite_source_grep_command = 'ack'
   let g:unite_source_grep_default_opts = '--no-heading --no-color -a -H'
   let g:unite_source_grep_recursive_opt = ''
endif

"some old map
"nnoremap <C-p> :Unite -start-insert file_rec/async<cr>
"nnoremap <space>/ :Unite -start-insert grep:.<cr>
"nnoremap <space>* :UniteWithCursorWord grep:.<cr>
"nnoremap <space>b :Unite -start-insert -quick-match buffer<cr>
"nnoremap <space>m :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

"airline
let g:bufferline_echo = 0

" YCM
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1 
let g:ycm_confirm_extra_conf = 0 "disable annomying "ycm_extra_conf.py. Load?" popup everytime

let g:ycm_show_diagnostics_ui =0 "disable syntax check
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!'
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

"UltiSnips
"I have no idea how it is works
function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsExpandTrigger="<tab>" 
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetsDir= '~/.vim/bundle/ultisnips/UltiSnips'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snippets']

"autoformat
let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = " --style=google --indent=spaces=2 --pad-oper --pad-header --indent-modifiers --attach-classes --indent-col1-comments --max-instatement-indent="
