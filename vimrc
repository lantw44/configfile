" vim: ts=4 sw=4 noet:
let $ERRFILE="/tmp/68c8bff5-0e99-4566-aa7a-14b7882887f9.err"
let $CC="cc"
let $CXX="c++"
let $CFLAGS="-Wall -pipe -g"
let $LDFLAGS=""
let g:quick_fix_window_on = 0
let g:use_plugins = 0
let g:use_powerline = 0
let g:use_powerline_fonts = 0
let g:use_youcompleteme = 0
set bs=2
set ls=2
set ts=4
set sw=4
set hid
set cin
set hls
set ru
set nocp
set hi=100
set tw=80
set cc=+1
set ve=block
set bg=light
let g:tex_flavor = 'tex'
syntax on
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7

function! SingleCompile()
	let file_suffix = expand("%:e")
	if file_suffix == "c"
		!${CC} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}
	elseif index(['cpp', 'CPP', 'cp', 'cxx', 'cc', 'c++'], file_suffix) >= 0
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

function! ToggleBackgroundColor()
	if &background == "light"
		set background=dark
		highlight PreProc ctermfg=darkcyan
	else
		set background=light
		highlight Comment ctermfg=darkcyan
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
map <F7> <C-w><C-w>
map <F8> :call ToggleBackgroundColor()<CR>
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

au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType c set omnifunc=ccomplete#Complete
au BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
au BufRead,BufNewFile *.json set ft=json
au BufRead,BufNewFile *.slim setfiletype slim
au BufRead,BufNewFile *.coffee setfiletype coffee

set tags+=~/.vim/tags

if g:use_plugins
	set rtp+=~/.vim/bundle/vundle
	call vundle#rc()
	Plugin 'gmarik/vundle'
	Plugin 'majutsushi/tagbar'
	Plugin 'scrooloose/nerdtree'
	Plugin 'othree/html5.vim'
	Plugin 'tkztmk/vim-vala'
	Plugin 'petRUShka/vim-opencl'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'elzr/vim-json'
	Plugin 'slim-template/vim-slim'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'gtags.vim'
	Plugin 'rails.vim'
	Plugin 'gtk-vim-syntax'

	if g:use_powerline
		Plugin 'powerline/powerline'
		set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
		if !g:use_powerline_fonts
			let g:powerline_config_overrides = { "common": { "dividers": {
			\	"left":  { "hard": "  ", "soft": " |" },
			\	"right": { "hard": "  ", "soft": " |" } } } }
		endif
	else
		Plugin 'bling/vim-airline'
		Plugin 'tpope/vim-fugitive'
		let g:aireline_detect_iminsert = 1
		let g:airline#extensions#tabline#enabled = 1
		if g:use_powerline_fonts
			let g:airline_powerline_fonts = 1
		endif
	endif

	if g:use_youcompleteme
		Plugin 'Valloric/YouCompleteMe'
	else
		Plugin 'Shougo/neocomplete.vim'
		Plugin 'Shougo/vimproc'
		Plugin 'Shougo/context_filetype.vim'
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#enable_auto_select = 1
		let g:neocomplete#enable_insert_char_pre = 1
		let g:neocomplete#enable_fuzzy_completion = 1
		let g:neocomplete#max_list = 10
		let g:neocomplete#data_directory = "~/tmp/neocomplete"
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

"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11
