map <F5> :!clear<CR>:!ruby %<CR>
map <F6> :!clear<CR>:!spec -c %<CR>

"command! Rubyrun call s:Rubyrun()
"nmap <F5> :Rubyrun<CR>
"
"function! s:Rubyrun()
"  :w
"  let ret = system("ruby %")
"  :echo ret
""  :w
""  let path = expand("%")
""  let syn = "javac ".path
""  let dpath = split(path,".java$")
""  let ret = system(syn)
""  if ret == ""
""    let syn = "java ".dpath[0]
""    let ret = system(syn)
""    :echo "====\r\n実行結果:\r\n".ret
""  else
""    :echo ret
""  endif
"endfunction


































