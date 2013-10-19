" Put stuff specifically to do with GUI Macvim in .gvimrc 
" as .gvimrc is loaded after this file by that program only.
"
set autoindent
set history=10


" make default buffer same as clipboard
set clipboard+=unnamed

if $BC != ""
	" set path used for searching
	set path=.,$MASTER,$BC/kclient,$BC/shared,$BC/**

	" tags file
	set tags=./tags,$BC/mastertags
	set viminfo='50,\"1000,:0,n$MASTER/viminfo
endif


" keyboard maps
	" F12 for next error in normal mode
	map <F12> <ESC>:cn<CR>
	" CTRL-C to copy in visual mode
	vmap <C-C>	"*y

" turn on syntax coloring and filetype detection
syntax on
filetype on

" pathogen support
execute pathogen#infect()
filetype plugin indent on

function SetTabs ()
" These tests have to be in an au command function for some reason
if &filetype == "c"
	" C specifics
	set cindent
	set fo=croq
	let c_space_errors=1
	set comments=sl:/*,mb:**,ex:*/
elseif &filetype == "ruby"
	" Ruby specifics
	set ts=2 bs=2 shiftwidth=2 smarttab expandtab
	set ruler
	set cinwords=if,else,while,do,for,switch,case
elseif &filetype == "haml"
	" HAML specifics
	set ts=2 bs=2 shiftwidth=2 smarttab expandtab
	set ruler
elseif &filetype == "scala"
	" Scala specifics
	set ts=2 bs=2 shiftwidth=2 smarttab expandtab
endif
endfunction
autocmd BufEnter * call SetTabs ()

" CoffeeScript override, ftplugin sets expandtab and shiftwidth
autocmd BufRead,BufNewFile *.coffee setlocal ts=2
" show coffee errors from make
" autocmd QuickFixCmdPost * nested cwindow 

" highlight trailing spaces in C like languages
let c_space_errors=1

" Octave/Matlab syntax overriding Objective C
autocmd BufRead,BufNewFile *.m,*.oct setlocal ts=4 shiftwidth=4

" Native markdown support does not recognize .md which is owned by modula2
autocmd BufRead,BufNewFile *.md set filetype=markdown


" Unicode editing
if has("multi_byte")
     set encoding=utf-8
     setglobal fileencoding=utf-8
     set fileencodings=utf-8,ucs-bom,iso-8859-15,iso-8859-3
else
     "echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif 

" these are common dyslexic misspellings
iab teh the
iab statment statement

" Restore cursor position in the irb vim gem. XXX Do we need this?
if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" support ctags if available
set tags=./tags;$HOME
