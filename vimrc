" Description: Vim configuration file
" Author: Philippe Pepiot <phil@philpep.org>

" No vi compatible
set nocompatible

" Use mouse
set mouse=a

" 3 lines visible around the cursor
set scrolloff=3

" Shell to use with :sh
set shell=zsh

" No bells
set errorbells
set novisualbell

" History
set history=100
set undolevels=150

" Don't show these file during completion
set suffixes+=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo,.mod

" Searching
set incsearch
set ignorecase
set smartcase

" Statusline
set laststatus=2
set ruler

" Folding
set foldmethod=marker

" shiftwidth
set sw=4
set ts=4

" paste/nopaste
set pastetoggle=<F11>

" Allow backspace in insert mode
set backspace=indent,eol,start

" For syntaxt/2html.vim
let use_xhtml=1
let html_ignore_folding=1

" Backup
set backup
if filewritable("$HOME/.vim/backup") == 2
	set backupdir=$HOME/.vim/backup
else
	call system("mkdir -p $HOME/.vim/backup")
	set backupdir=$HOME/.vim/backup
endif

filetype on
filetype plugin on
filetype indent on
autocmd FileType text setlocal textwidth=78
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

autocmd BufRead,BufNewFile lighttpd.conf set ft=conf
autocmd BufRead,BufNewFile *.conkyrc set ft=conkyrc
autocmd BufRead,BufNewFile *.html,*.mako set ft=mako
autocmd Filetype java setlocal omnifunc=javacomplete#Complete

syntax on

" :Man
runtime ftplugin/man.vim
nnoremap K :Man <cword><CR>
let $PAGER='less'

" Mappings
map <F5> <Esc>gg=G''
map <F6> :TlistToggle
map <F7> :TlistUpdate
map <A-Right> gt
map <A-Left> gT

