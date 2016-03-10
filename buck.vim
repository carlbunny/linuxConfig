" put into ~/.vim/compiler/buck.vim
" cd ~/.vim/compiler/buck.vim && ln -s ~/linuxConfig/buck.vim buck.vim 

if exists("current_compiler")
    finish
endif
let current_compiler = "buck"

let s:cpo_save = &cpo
set cpo-=C

" Use absolute path as buck by default always start from fbcode/
"
CompilerSet makeprg=buck\ build\ --report-absolute-paths
CompilerSet errorformat=
  \%E%f:%l:%c:\ error:\ %m,
  \%W%f:%l:%c:\ warning:\ %m,
  \%I%f:%l:%c:\ note:\ %m,
  \%\\e

let &cpo = s:cpo_save
unlet s:cpo_save
