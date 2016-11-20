if exists("b:current_syntax")
  finish
  endif

  syn match log_warning 'W\d\{4}'
  syn match log_error 'E\d\{4}'
  syn match log_fatal 'F\d\{4}.*'
  syn region log_string        start=/'/ end=/'/ end=/$/ skip=/\\./
  syn region log_string        start=/"/ end=/"/ end=/$/ skip=/\\./

  syn match log_number '0x[0-9a-fA-F]*\|\<\d[0-9a-fA-F]*'

  syn match thread_id '\d\+' contained
  syn match log_time '\d\d:\d\d:\d\d\.\d\{6} ' contained nextgroup=thread_id skipwhite
  syn match file_name ' .*\.\(cpp\|h\)\:\d\+\]' contains=log_time

  syn match uuid '[0-9a-f]\{8}-[0-9a-f]\{4}-[0-9a-f]\{4}-[0-9a-f]\{4}-[0-9a-f]\{12}'

  hi def link log_error ErrorMsg
  hi def link log_fatal ErrorMsg
  hi def log_string ctermfg=magenta
  hi def log_time ctermfg=darkgreen
  hi def log_number cterm=bold
  hi def log_warning ctermbg=darkyellow ctermfg=white
  hi def uuid cterm=bold
  hi def thread_id  ctermfg=darkred
  hi def file_name ctermfg=brown
  let b:current_syntax = "glog"
