let $ERRFILE="/tmp/f8fe1f28-6e6e-11e0-b22e-000c760ae4c6.err"
let $CFLAGS="-Wall -O2 -pipe"
let $LDFLAGS=""
set bs=2
set ls=2
set ts=4
set sw=4
set cindent
set hls
set ru
set nocp
syntax on
set background=light
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7

function! SingleCompile()
	let file_suffix = expand("%:e")
	if file_suffix == "c"
		!gcc ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${ERRFILE}
		cg ${ERRFILE}
	elseif file_suffix == "cpp"
		!g++ ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${ERRFILE}
		cg ${ERRFILE}
	else
		echo "This file has an UNKNOWN SUFFIX!"
	endif
endfunction

map <F1> :echo "CFLAGS="$CFLAGS"\n"<CR>:let $CFLAGS="-Wall -O2 -pipe
map <F2> :cl<CR>
map <F3> :cp<CR>
map <F4> :cn<CR>
map <F5> :tabp<CR>
map <F6> :tabn<CR>
map <F7> :set background=light<CR>:highlight Comment ctermfg=darkcyan<CR>
map <F8> :set background=dark<CR>:highlight PreProc ctermfg=darkcyan<CR>
map <F9> :call SingleCompile()<CR>
map <F10> :make<CR>
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
