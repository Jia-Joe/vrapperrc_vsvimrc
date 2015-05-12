set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set ai "设置自动缩进
set cindent "设置使用 C/C++ 语言的自动缩进方式
set shiftwidth=2   "设置自动缩进 2 个空格
set sts=4          "即设置 softtabstop 为 4. 输入 tab 后就跳了 4 格
set tabstop=4      "实际的 tab 即为 4 个空格, 而不是缺省的 8 个
set expandtab      "在输入 tab 后, vim 用恰当的空格来填充这个 tab

set guifont=Courier:h12:cANSI
set encoding=utf-8
set fileencodings=utf-8,chinese
set termencoding=utf-8
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
set guifont=Consolas:h12  


set nu! 
syntax enable 
syntax on 
set background=dark
"set background=light
colorscheme solarized

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

