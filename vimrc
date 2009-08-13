scriptencoding utf-8
" File: Vim configuration file
" Author: philpep <phil@philpep.org>
" Www: http://philpep.org

" {{{ global configuration 
" Be no compatible with vi
set nocompatible

" No bells
set errorbells
set novisualbell

set backspace=indent,eol,start

" History size
set history=100
" Undo size
set undolevels=150
" Don't show these file during completion
set suffixes+=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo,.mod

set showmatch
set matchtime=2

" search as I type
set incsearch
" ignore case when searching
set ignorecase
" override ignorecase if there are caps
set smartcase
" Show cursor position
set ruler
" Options de folding
set foldmethod=marker
" Don't redraw screen when executing macros
set lazyredraw
" indent size
set shiftwidth=4
set autoindent
set smartindent
" Use mouse for all mode
set mouse=a
" 3 lines visible around the cursor
set scrolloff=3
set sidescrolloff=5
set scrolljump=1
" Shell to use with :sh
set shell=zsh
" paste/nopaste
set pastetoggle=<F11>
" force file encoding
set fileencodings=utf-8,latin1,default
" grep command
set grepprg=grep\ -nH\ $*


" Activer le backup
set backup
" On teste si le repertoire existe
if filewritable(expand("~/.vim/backup")) == 2
   set backupdir=$HOME/.vim/backup
else
   " sinon on le crée
   if has("unix") || has("win32unix")
      call system("mkdir -p $HOME/.vim/backup")
      set backupdir=$HOME/.vim/backup
   endif
endif
" }}} 

" {{{ Autocmd 
if has("autocmd")
   " Filetype
   filetype on
   filetype plugin on
   filetype indent on
   " Lire des pdf
   au!
   autocmd BufReadpre *.pdf set ro
   autocmd BufReadPost *.pdf %!pdftotext -nopgbrk "%" - | fmt -csw78
   " Put these in an autocmd group, so that we can delete them easily.
   augroup vimrc
      au!

      " For all text files set 'textwidth' to 78 characters.
      autocmd FileType text setlocal textwidth=78

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
	       \ if line("'\"") > 0 && line("'\"") <= line("$") |
	       \   exe "normal! g`\"" |
	       \ endif

   augroup END
   autocmd FileType c      set omnifunc=ccomplete#Complete
   autocmd FileType css    set omnifunc=csscomplete#CompleteCSS
   autocmd FileType html   set omnifunc=htmlcomplete#CompleteTags
   autocmd FileType php    set omnifunc=phpcomplete#CompletePHP
   autocmd FileType python set omnifunc=pythoncomplete#Complete
   autocmd FileType ruby   set omnifunc=rubycomplete#Complete
   autocmd FileType sql    set omnifunc=sqlcomplete#Complete
   autocmd FileType xml    set omnifunc=xmlcomplete#CompleteTags
   autocmd BufRead,BufNewFile lighttpd.conf set ft=conf
   autocmd BufRead,BufNewFile *conkyrc set ft=conkyrc
   autocmd BufRead,BufNewFile *.html,*.mako set ft=mako
endif
" }}}


if has("syntax")
   syntax on
endif

" {{{ Mapping
if exists(":runtime")
   runtime ftplugin/man.vim
   if exists(":nnoremap")
      nnoremap K :Man <cword><CR>
   endif
endif

if exists(":map")
   " some usefull key mapping
   map <F5> <Esc>gg=G''
   map <F6> :TlistToggle
   map <F7> :TlistUpdate
   map <A-Right> gt
   map <A-Left> gT
endif

if exists(":command")
   " open urls with firefox
   command -bar -nargs=1 OpenURL :!firefox3 <args>
endif
" }}}

