" ____    ____  __   _______   _______ 
" \   \  /   / |  | |       \ |   ____|
"  \   \/   /  |  | |  .--.  ||  |__   
"   \      /   |  | |  |  |  ||   __|  
"    \    /    |  | |  '--'  ||  |____ 
"     \__/     |__| |_______/ |_______|
"                                      

autocmd BufNewFile *.lua 0r /tmp/lua.template
autocmd BufNewFile *.lua normal gnp
autocmd BufNewFile *.php 0r /tmp/php.template
autocmd BufNewFile *.php normal gnp
autocmd BufRead,BufNewFile *.conf setfiletype conf
autocmd BufRead *.php set includeexpr=substitute(v:fname,'\\\','/','g')
autocmd BufRead *.php set include=^#\s*use
autocmd BufRead *.php set suffixesadd+=.php
autocmd BufWinEnter *.mako set filetype=html
autocmd BufWinEnter *.sls set filetype=yaml
autocmd BufWinEnter *.tp set filetype=html
autocmd BufWinEnter *.volt set filetype=html
autocmd GUIEnter * silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
call system('bash ~/.vim/lua.template > /tmp/lua.template')
call system('bash ~/.vim/php.template > /tmp/php.template')
call system('mkdir -p ~/.vimtmp/undodir ~/.vimtmp/backupdir ~/.vimtmp/directory')
colorscheme torte
filetype on
filetype plugin indent on
filetype plugin on
let g:is_bash=1
let &t_EI .= "\<Esc>[?2004l"
let &t_SI .= "\<Esc>[?2004h"
let $VIMFILES=$HOME.'/.vim'
let @w = 'x~n'
nmap <c-l> <esc>:noh<cr>
nmap <leader>3 :NERDTreeFind<cr>
nmap <leader>a :set filetype=awk        <CR>
nmap <leader>c :set filetype=css        <CR>
nmap <leader>d :set filetype=htmldjango <CR>
nmap <leader>e :set filetype=sed        <CR>
nmap <leader>h :set filetype=html       <CR>
nmap <leader>j :set filetype=javascript <CR>
nmap <leader>l :set filetype=lua        <CR>
nmap <leader>m :set filetype=markdown   <CR>
nmap <leader>p :set filetype=php        <CR>
nmap <leader>s :set filetype=sh         <CR>
nmap <leader>t :set filetype=txt        <CR>
nmap <leader>v :set filetype=vim        <CR>
nmap <leader>y :set filetype=python     <CR>
set ambiwidth=double
set autoread
set autowriteall
set backup
set bs+=start
set smartindent cindent autoindent
set shiftwidth=4 tabstop=4 smarttab
set clipboard+=unnamed
set complete-=i
set cursorline
set expandtab  
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936 fileencoding=utf-8
set foldmethod=manual
set hidden hlsearch
set ignorecase smartcase
set noautochdir
set noshowmatch
set nowrapscan
set number      
set pastetoggle=<F5>
set path+=./model/,./ctrl/,./lib/,*/templates/,*/static/,..,*/src/main/java/
set printoptions=formfeed:y,header:0,paper:A4,duplex:off,syntax:n
set scrolloff=1                             
set shell=/bin/bash
set nocompatible               
set showcmd                                 " Show cmd in vim-cmdline.
set t_Co=256                                " Make vim look better in putty.
set textwidth=0
set undodir=~/.vimtmp/undodir 
            \ directory=~/.vimtmp/directory 
            \ backupdir=~/.vimtmp/backupdir 
            \ viewdir=~/.vimtmp/view
            \ undofile 
set vb t_vb=                                " Turn off bi-sound of vim.
set wildignore+=*.git\\*,*.tgz,*.zip,*.url,*.pyc,*.class
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

"
" utime.vim
"
let g:timeStampFormat = '170101'
let g:timeStampString = '%y%m%d'
let g:timeStampLeader = 'version'
