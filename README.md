# Vide

Vide is short for [Vi]m I[DE]. This is a vim config project.

## Install

    cd ~
    git clone https://github.com/mrytsr/vide
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd .vim && vim +BundleInstall +qa

## Features

### Statusline

Replace airline and powerline.
Origin vim config is much faster!

    (Vide)  README.md[+] /home/tjx/vide [unix:utf-8:MARKDOWN]       18,5      50%
    +----+  +----------+ +------------+ +-------------------+       +--+      +-+
    1       2         3                 4                           5         6

1. logo
1. relative path
1. absolute path of directory
1. format : file-encoding : filetype
1. row-position, col position
1. percent of rows

### Shortcuts

- ctrl-L clear search highlight
- \3 nerdtree-find
- \a :set filetype=awk
- \c :set filetype=css
- \d :set filetype=htmldjango 
- \e :set filetype=sed
- \h :set filetype=html
- \j :set filetype=javascript 
- \l :set filetype=lua
- \m :set filetype=markdown
- \p :set filetype=php
- \s :set filetype=sh
- \t :set filetype=txt
- \v :set filetype=vim
- \y :set filetype=python

### Backup
- ~/.vimtmp/undodir
- ~/.vimtmp/backupdir
- ~/.vimtmp/directory .swp files

### Template
call system('bash ~/.vim/lua.template > /tmp/lua.template')
call system('bash ~/.vim/php.template > /tmp/php.template')

## Plugins

### php-manual

shift-K on php function to lookup in php-manual

### utime.vim

let g:timeStampFormat = '170101'
let g:timeStampString = '%y%m%d'
let g:timeStampLeader = 'version'


### php gf
autocmd BufRead *.php set includeexpr=substitute(v:fname,'\\\','/','g')
autocmd BufRead *.php set include=^#\s*use
autocmd BufRead *.php set suffixesadd+=.php


### fix filetype
autocmd BufRead,BufNewFile *.conf setfiletype conf
autocmd BufWinEnter *.mako set filetype=html
autocmd BufWinEnter *.sls set filetype=yaml
autocmd BufWinEnter *.tp set filetype=html
autocmd BufWinEnter *.volt set filetype=html

### colorscheme
colorscheme torte

### 
let $VIMFILES=$HOME.'/.vim'

set ambiwidth=double
set autoindent    
set autoread
set autowriteall
set backup
set backupdir=~/.vimtmp/backupdir
set bs+=start
set cindent       
set clipboard+=unnamed
set complete-=i
set cursorline
set directory=~/.vimtmp/directory
set encoding=utf-8
set expandtab  
set fileencodings=ucs-bom,utf-8,cp936       
set fileencoding=utf-8
set foldmethod=manual
set helplang=cn                             " 中文帮助文档
set hidden     
set hlsearch
set ignorecase smartcase                    " 搜索时忽略大小写，除非在有一个或以上大写字母时
set noautochdir
set nocompatible               
set noshowmatch
set nowrapscan
set number      
set pastetoggle=<F5>
set path+=./model/,./ctrl/,./lib/,*/templates/,*/static/,..,*/src/main/java/
set printoptions=formfeed:y,header:0,paper:A4,duplex:off,syntax:n
set scrolloff=1                             " 光标移动到buffer的顶部和底部时保持3行距离
set shell=/bin/bash
set shiftwidth=4
set showcmd                                 " 输入的命令显示出来，看的清楚些
set smartindent   
set smarttab     
set tabstop=4   
set t_Co=256                                " 兼容putty下的vim
set textwidth=0                             " 关闭自动换行
set undodir=$HOME/.vimtmp/undodir
set undofile 
set vb t_vb=                                " vim彻底关闭报错声
set viewdir=~/.vimtmp/view
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*.tgz,*.zip,*.url,*.pyc,*.class
syntax on

"
" statusline
"
set laststatus=2
set statusline=(Vide)\ \ %<%f
set statusline+=%w%h%m%r                 
set statusline+=\ %{getcwd()}
set statusline+=\ [%{&ff}:%{&fenc}:%Y]
set statusline+=%=%-14.(%l,%c%V%)\ %p%%


"
" Vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'vim-scripts/DrawIt'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'vim-syntastic/syntastic'
Plugin 'alvan/vim-php-manual'
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'ctrlp.vim'
Plugin 'tmhedberg/matchit'
Plugin 'airblade/vim-gitgutter'
Plugin 'stephpy/vim-yaml'
Plugin 'tpope/vim-abolish'
Plugin 'mrytsr/utime.vim'
filetype plugin indent on
call vundle#end()
let g:vim_markdown_folding_disabled = 1
let g:gitgutter_max_signs=10000

"
" syntastic
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_quiet_messages = { "level": "warnings" }

"
" NERDTree
"
let g:NERDTreeDirArrowExpandable  = '@'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowHidden            = 0
let g:NERDTreeBookmarksFile         = $HOME.'/.vimtmp/NerdBookmarks.txt'
let g:NERDTreeShowBookmarks         = 1
let g:NERDTreeShowFiles             = 1
let g:NERDTreeShowLineNumbers       = 0
let g:NERDTreeWinSize               = 29
let g:NERDTreeMinimalUI             = 1
let g:NERDTreeDirArrows             = 1
let g:NERDTreeIgnore                = [
            \ '.*\.class', 
            \ '.*\.pyc', 
            \ '.*\.chm', 
            \ '.*\.ttf',
            \ '.*\.lnk',
            \ '.*\.cproj',
            \ '.*\.exe',
            \ '.*\.dll',
            \ '.*\.out',
            \ '.*\.files',
            \ '.*\.zip',
            \ '.*\.rar',
            \ '.*\.gif'
            \ ]
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?" 
            \ }

"
" ctrlp
"
" Making CtrlP.vim load 100x faster — A Tiny Piece of Vim — Medm 
" https://medium.com/a-tiny-piece-of-vim/making-ctrlp-vim-load-100x-faster-7a722fae7df6#.emcvo89nx
let g:ctrlp_user_command = [
            \ '.git/', 
            \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
            \ ]
let g:ctrlp_match_window       = 'bottom,order:btt,min:5,max:5,results:10'
let g:ctrlp_cmd                = 'CtrlPMixed'
let g:ctrlp_mruf_default_order = 1
