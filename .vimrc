"カラースキーマ設定
colorscheme zenburn

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
"set paste
"set nocompatible
"set runtimepath=~/.vim
set backspace=indent,eol,start
set nobackup
set noswapfile
set guioptions=""
set clipboard=unnamed
set iminsert=0
set imsearch=-1

syntax on
filetype on
filetype indent on
filetype plugin on

"レジスタに格納しないようにする
nnoremap x "_x
vnoremap x "_x
nnoremap c "_c
vnoremap c "_c
nnoremap d "_d
vnoremap d "_d

"c-xで切り取り
noremap <C-x> d
vnoremap <C-x> d
nnoremap <C-x><C-x> dd

"ノーマルモード時Enterで改行
noremap <CR> o<ESC>
"ノーマルモード時BackSpaceで行の削除
nnoremap <BS> "_ddk

"カーソル移動で行移動できるようにする
set whichwrap=<,>,[,]
"H lキーを左右キーに入れ替える
map h <Left>
map l <Right>
"カーソルを表示行で移動する。
map j gj
map k gk
map <Down> gj
map <Up>   gk
nmap <c-z> :redraw<CR>

" ポップアップメニューのカラーを設定
hi Pmenu ctermbg=0
hi PmenuSel ctermbg=4
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermbg=3

"BufExplorerを起動
nmap <c-l> :BufExplorer<CR>

"インデント時のオートコメントOFF
if has("autocmd")
  autocmd FileType *
  \ let &l:comments
        \=join(filter(split(&l:comments, ','), 'v:val =~ "^[sme]"'), ',')
endif

"Cdd
cabbrev cdd Cdd

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Mode でのコメント挿入、解除
vmap ,# :s/^/#/<CR>:nohlsearch<CR>
vmap ,/ :s/^/\/\//<CR>:nohlsearch<CR>
vmap ,> :s/^/> /<CR>:nohlsearch<CR>
vmap ," :s/^/\"/<CR>:nohlsearch<CR>
vmap ,' :s/^/\'/<CR>:nohlsearch<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>
vmap ,! :s/^/!/<CR>:nohlsearch<CR>
vmap ,; :s/^/;/<CR>:nohlsearch<CR>
vmap ,- :s/^/--/<CR>:nohlsearch<CR>
vmap ,c :s/^\/\/\\|^--\\|^> \\|^[#"'%!;]//<CR>:nohlsearch<CR>

" wrapping comments
vmap ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vmap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
vmap ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vmap ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>

" block comments
vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>
"""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
