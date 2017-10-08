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
