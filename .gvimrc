" Only put stuff here that applies to the GUI MacVim
" General stuff belongs in .vimrc which is executed first
"
set anti gfn=Monaco:h13
set columns=132 lines=55
set go-=T
"winpos 80 50

highlight Comment guifg=DarkGreen ctermfg=DarkGreen
highlight cComment guifg=DarkGreen ctermfg=DarkGreen
highlight Statement gui=bold guifg=Blue ctermfg=Blue
highlight StorageClass gui=bold guifg=Blue ctermfg=Blue
highlight Type gui=bold guifg=Blue term=bold ctermfg=Blue
highlight Constant guifg=DarkRed ctermfg=DarkRed
highlight Macro guifg=Red ctermfg=Red
"highlight String guifg=DarkBlue ctermfg=DarkBlue
highlight ToDo guifg=Black guibg=Yellow ctermbg=Magenta
highlight Function guifg=Black ctermfg=Black
