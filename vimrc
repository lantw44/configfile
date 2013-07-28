let $ERRFILE="/tmp/aa1ab433-b660-11e2-a69a-000c760ae4c6.err"
let $CC="cc"
let $CXX="c++"
let $CFLAGS="-Wall -pipe -g"
let $LDFLAGS=""
let g:quick_fix_window_on = 0
let g:plugins_enabled = 0
let g:use_neocomplete = 0
set bs=2
set ls=2
set ts=4
set sw=4
set cin
set hls
set ru
set nocp
set hi=100
set tw=80
set cc=+1
set ve=block
set bg=light
syntax on
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7

function! SingleCompile()
	let file_suffix = expand("%:e")
	if file_suffix == "c"
		!${CC} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}
	elseif file_suffix == "cpp"
		!${CXX} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
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

function! LoadGtkSyntaxFiles()
	for i in ['atk', 'atspi', 'cairo', 'clutter', 'dbusglib', 'evince', 'gdkpixbuf', 'gimp', 'glib', 'gnomedesktop', 'gobjectintrospection', 'gstreamer', 'gtk2', 'gtk3', 'gtkglext', 'gtksourceview', 'jsonglib', 'libgsf', 'libnotify', 'librsvg', 'libsoup', 'libunique', 'libwnck', 'pango', 'poppler', 'vte', 'xlib' ]
	  execute 'runtime! syntax/' . i . '.vim'
	  execute 'let ' . i . '_deprecated_errors = 1'
	endfor
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
nmap <Tab> <C-w><C-w>
nmap <S-Tab> <C-w>W

au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType c set omnifunc=ccomplete#Complete
au BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

set tags+=~/.vim/tags

if g:plugins_enabled
	set rtp+=~/.vim/bundle/vundle
	set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
	call vundle#rc()
	Bundle 'gmarik/vundle'
	Bundle 'Lokaltog/powerline'
	Bundle 'majutsushi/tagbar'
	Bundle 'scrooloose/nerdtree'
	Bundle 'othree/html5.vim'
	Bundle 'tkztmk/vim-vala'
	Bundle 'gtk-vim-syntax'
	if g:use_neocomplete
		Bundle 'Shougo/neocomplete.vim'
		Bundle 'Shougo/vimproc'
		Bundle 'Shougo/context_filetype.vim'
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#enable_auto_select = 1
		let g:neocomplete#enable_insert_char_pre = 1
		let g:neocomplete#enable_fuzzy_completion = 1
		let g:neocomplete#max_list = 10
		let g:neocomplete#data_directory = "~/tmp/neocomplete"
	else
		Bundle 'Valloric/YouCompleteMe'
	endif
	au FileType c call LoadGtkSyntaxFiles()
	au FileType cpp call LoadGtkSyntaxFiles()
endif

if has("cscope")                                 
    set cst
    set csverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"set guifont=Liberation\ Mono\ for\ Powerline\ 11
