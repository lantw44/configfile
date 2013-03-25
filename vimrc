let $ERRFILE="/tmp/fc0edaa9-1383-11e1-8659-000c760ae4c6.err"
let $CFLAGS="-Wall -pipe -g"
let $LDFLAGS=""
let g:quick_fix_window_on = 0
set bs=2
set ls=2
set ts=4
set sw=4
set cindent
set hls
set ru
set nocp
set ve=block
syntax on
set background=light
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7

function! SingleCompile()
	let file_suffix = expand("%:e")
	if file_suffix == "c"
		!gcc ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}
	elseif file_suffix == "cpp"
		!g++ ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}
	else
		echo "This file has an UNKNOWN SUFFIX!"
	endif
endfunction

function! ToggleQuickFixWindow()
	if g:quick_fix_window_on
		cclose
		let g:quick_fix_window_on = 0
	else
		copen
		let g:quick_fix_window_on = 1
	endif
endfunction

map <F1> :set foldmethod=syntax
map <F2> :call ToggleQuickFixWindow()<CR>
map <F3> :cp<CR>
map <F4> :cn<CR>
map <F5> :tabp<CR>
map <F6> :tabn<CR>
map <F7> :set background=light<CR>:highlight Comment ctermfg=darkcyan<CR>
map <F8> :set background=dark<CR>:highlight PreProc ctermfg=darkcyan<CR>
map <F9> :call SingleCompile()<CR>
map <F10> :echo "CFLAGS="$CFLAGS"\n"<CR>:let $CFLAGS="-Wall -g -pipe
map <F11> :echo "LDFLAGS="$LDFLAGS"\n"<CR>:let $LDFLAGS="
map <F12> :!less -R %:p:.<CR>
imap <F1> <ESC><F1>
imap <F2> <ESC><F2>a
imap <F3> <ESC><F3>a
imap <F4> <ESC><F4>a
imap <F5> <ESC><F5>a
imap <F6> <ESC><F6>a
imap <F7> <ESC><F7>a
imap <F8> <ESC><F8>a
imap <F9> <ESC><F9>
imap <F10> <ESC><F10>
imap <F11> <ESC><F11>
imap <F12> <ESC><F12>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

set tags+=~/.vim/tags
