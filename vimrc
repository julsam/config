scriptencoding utf-8
" File: Vim configuration file
" Autor: philpep
" Www: http://philpep.org
" Thanks: Geekounet http://poildetroll.net
"
"
" Actualise le title du terminal
set title
" Non compatible avec vi
set nocompatible
" Pas de beeps !
set errorbells
set novisualbell
set t_vb=
" Backspace
set backspace=indent,eol,start
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

" Taille de l'historique
set history=100
" Taille des undo (annuler)
set undolevels=150
" Suffixes a cacher :
set suffixes+=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo,.mod

" runtime path
set runtimepath+=/usr/share/vim/2pdf

" Voir les ouvertures et fermetures de ( { etc...
set showmatch
set matchtime=2
" hilight search
set hlsearch
" search as I type
set incsearch
" ignore case when searching
set ignorecase
" override ignorecase if there are caps
set smartcase

" Afficher les commandes incompletes
set showcmd
" Affiche la position du curseur
set ruler

" Options de folding
set foldmethod=marker
" Si on est dans un terminal rapide
set ttyfast
" Permet de ne pas actualiser l'écran quand
" un sript vim fait une opperation
set lazyredraw
" Taille indentation
set shiftwidth=3
set autoindent
set smartindent
" Utiliser la souris
set mouse=a
" 3 lines visible around the cursor
set scrolloff=3
set sidescrolloff=5
set scrolljump=1
" Un shell qui envoie
set shell=zsh
" paste/nopaste
set pastetoggle=<F11>
" force file encoding
set fileencodings=utf-8,latin1,default
" grep command
set grepprg=grep\ -nH\ $*

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
endif
" Coloration syntaxique
if has("syntax")
   syntax on
endif


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
   map <F9> :DiffChangesDiffToggle
   map <F10> :DiffChangesPatchToggle
   map <A-Right> gt
   map <A-Left> gT
endif

if exists(":command")
   " open urls with firefox
   command -bar -nargs=1 OpenURL :!firefox <args>
endif

