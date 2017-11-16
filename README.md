# Vide

Vide is short for [Vi]m I[DE], This is a vim config project.
(Vide是[V]im [I]DE 的缩写，是一个vim配置项目)

<!-- vim-markdown-toc GFM -->

* [Install (安装)](#install-安装)
* [Features (功能列表)](#features-功能列表)
    * [Statusline (状态栏)](#statusline-状态栏)
    * [Shortcuts (快捷键)](#shortcuts-快捷键)
    * [Backup (备份路径)](#backup-备份路径)
    * [Template (模板)](#template-模板)
* [Plugins (插件列表)](#plugins-插件列表)
    * [php-manual](#php-manual)
    * [utime.vim](#utimevim)
    * [_rm_](#rm)

<!-- vim-markdown-toc -->

## Install (安装)

    cd ~
    git clone https://github.com/mrytsr/vide
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd .vim && vim +BundleInstall +qa

## Features (功能列表)

### Statusline (状态栏)

Origin vim config statusline, much faster than airline or powerline!
(vim原生实现的状态栏，比airline或者powerline的更快！)

    (Vide)  README.md[+] /home/tjx/vide [unix:utf-8:MARKDOWN]       18,5      50%
    +----+  +----------+ +------------+ +-------------------+       +--+      +-+
    1       2         3                 4                           5         6

1. Logo
1. Relative path (相对路径)
1. Absolute path of directory (绝对路径)
1. Format : file-encoding : filetype (文件类型)
1. Row-position, col position (行号，列号)
1. Percent of rows (当前行在总行数中的百分比)

### Shortcuts (快捷键)

- ctrl-L clear search highlight
- \3 NERDTree-Find
- \a :set filetype=awk
- \c :set filetype=css
- \h :set filetype=html
- \j :set filetype=javascript 
- \l :set filetype=lua
- \m :set filetype=markdown
- \p :set filetype=php
- \s :set filetype=sh
- \v :set filetype=vim
- \y :set filetype=python

### Backup (备份路径)
- ~/.vimtmp/undodir
- ~/.vimtmp/backupdir
- ~/.vimtmp/directory .swp files

### Template (模板)
- call system('bash ~/.vim/lua.template > /tmp/lua.template')
- call system('bash ~/.vim/php.template > /tmp/php.template')

## Plugins (插件列表)

### php-manual

Shift-K on php function to lookup in php-manual

### utime.vim

    let g:timeStampFormat = '170101'
    let g:timeStampString = '%y%m%d'
    let g:timeStampLeader = 'version'

### _rm_
"
" Vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'prettier/vim-prettier'
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
" Plugin 'mrytsr/utime.vim'
filetype plugin indent on
call vundle#end()

