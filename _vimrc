set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Sets how many lines of history VIM has to remember
set history=50

" Always show the status line

set nobackup
set ai "设置自动缩进
set cindent "设置使用 C/C++ 语言的自动缩进方式
set shiftwidth=4   "设置自动缩进 2 个空格
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



"let g:indentLine_color_gui = '#A4E57E'
"let g:indentLine_color_gui = '#336699' "Blue
let g:indentLine_color_gui = '#586e75' "Base01
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 4)
"let g:indentLine_char = '|'

"切换显示菜单栏Alt+m
set guioptions-=m
set guioptions-=T
map <silent> <A-m> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

imap { {}<ESC>i<CR><ESC>O
imap ( ()<ESC>i
imap [ []<ESC>i
imap jj <Left><ESC> 
inoremap " ""<ESC>i
" 在插入模式下使用光标移动指令 'A'代表Alt键
inoremap <C-j> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <C-k> <Right>
" 在插入模式下使用光标移动一个单词
inoremap <A-h> <C-Left>
inoremap <A-l> <C-Right>
 
" 在插入模式下<C-k>用来插入特殊字符，详细内容可参考:help digraph-table
" 在插入模式下<C-j>用来输入一个回车键
 
" 使用 Alt 键移动到行首、行尾、上一行行首、下一行行尾
inoremap <C-h> <Esc>^i
inoremap <C-l> <End>
inoremap <A-K> <Esc>k$a
inoremap <A-J> <Esc>j$a
 
" 删除光标前面、后面的一个字符
"inoremap <A-f> <C-o>x
inoremap <A-d> <BACKSPACE>
inoremap <A-c> <Right><Esc>s
inoremap <A-y> <C-o>Y

" 插入到大/小括号外另起一行
inoremap <A-g> <Esc>jo
inoremap <A-i> <Esc>A;<CR>
inoremap <A-m> <Esc>A<SPACE>{}<ESC>i<CR><ESC>O
inoremap <BACKSPACE> <Esc>kA<BACKSPACE>

" 在光标下方，上方插入新行
inoremap <A-o> <Esc>o
inoremap <A-O> <Esc>O
inoremap <A-p> <C-o>p
inoremap <A-P> <C-o>P
inoremap <A-v> <Esc>V
 
" 删除当前行
inoremap <C-d> <C-o>dd
 
" 删除当前行并重写<-------------------
inoremap <A-s> <Esc>S

" 删除目标所在的单词<-----------------
inoremap <A-,> <C-[>diwi 
inoremap <A-.> <C-o>diw
 
" 取消高亮<---------------------------
map <A-/> :nohlsearch<CR>
 
" 插入模式下滚屏
:inoremap <A-e> <C-X><C-E>
:inoremap <A-q> <C-X><C-Y>
 
" 插入模式下的撤销操作
inoremap <A-u> <C-o>u
inoremap <A-r> <C-o><C-r>
vertical all

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

