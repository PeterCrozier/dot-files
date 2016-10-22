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

" map cmd F13 to run Dash via the Dash.vim plugin
:nnoremap <D-F13> :Dash<cr>

" turn on syntax coloring and filetype detection
syntax on
filetype on

" pathogen support
execute pathogen#infect()
filetype plugin indent on

function SetTabs ()
" These tests have to be in an au command function called per buffer/window
if &filetype == "c"
	" C specifics, default fo=croql
	setlocal formatoptions-=o	" don't autocomment new lines added with o or O
	setlocal formatoptions+=j	" join comments sensibly
	setlocal comments=sl:/*,mb:**,ex:*/,:// 
	setlocal commentstring=//\	%s
elseif &filetype == "arduino"
	" C specifics, default fo=croql
	setlocal formatoptions-=o	" don't autocomment new lines added with o or O
	setlocal formatoptions+=j	" join comments sensibly
	setlocal comments=sl:/*,mb:**,ex:*/,:// 
	setlocal commentstring=//\	%s
	setlocal cindent
elseif &filetype == "ruby"
	" Ruby specifics
	setlocal ts=2 bs=2 shiftwidth=2 smarttab expandtab
	setlocal formatoptions-=o	" don't autocomment new lines added with o or O
	setlocal formatoptions+=j	" join comments sensibly
elseif &filetype == "haml"
	" HAML specifics
	setlocal ts=2 bs=2 shiftwidth=2 smarttab expandtab
elseif &filetype == "scala"
	" Scala specifics
	setlocal ts=2 bs=2 shiftwidth=2 smarttab expandtab
elseif &filetype == "swift"
	" Swift specifics, defaults to 2 soft spaces, use hard tabs
	" using pathogen bundle: https://github.com/Keithbsmiley/swift.vim
	setlocal ts=8 shiftwidth=0 softtabstop=0 nosmarttab noexpandtab
	setlocal commentstring=//\	%s
elseif &filetype == "verilog"
	" the built-in syntax wraps at 78
	setlocal textwidth=0
	setlocal formatoptions+=j	" join comments sensibly
	setlocal formatoptions-=o	" don't autocomment new lines added with o or O
	setlocal comments=sl:/*,mb:**,ex:*/,:// 
	setlocal commentstring=//\	%s
	setlocal cindent
endif
endfunction
autocmd BufEnter * call SetTabs()

" CoffeeScript override, ftplugin sets expandtab and shiftwidth
autocmd BufRead,BufNewFile *.coffee setlocal expandtab smarttab shiftwidth=2 ts=2
" show coffee errors from make
" autocmd QuickFixCmdPost * nested cwindow 

" highlight trailing spaces in Ruby and C like languages
let c_space_errors=1
let ruby_space_errors=1

" use last line for position
set ruler

" Octave/Matlab syntax overriding Objective C
function MatTabs ()
if &filetype == "matlab"
	set ts=4 shiftwidth=4 expandtab
endif
endfunction
autocmd BufRead,BufNewFile *.m,*.oct call MatTabs ()

" Native markdown support does not recognize .md which is owned by modula2
autocmd BufRead,BufNewFile *.md set filetype=markdown

" MIT 6.004 jsim simulator netlist format, consider same as spice
autocmd BufRead,BufNewFile *.jsim set filetype=spice

" verilog header files
autocmd BufRead,BufNewFile *.vh set filetype=verilog

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

" run clang-format via CTRL-K
map <C-K> :pyfile /usr/local/bin/clang-format.py<cr><cr>

" fancy matching begin/end in verilog, ruby etc.
" included as a macro in vim 6.0+
runtime macros/matchit.vim

" syntastic flags
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
