# Vide

<!-- vim-markdown-toc GFM -->

* [Install (安装)](#install-安装)
* [Upgrade Plugins (升级插件)](#upgrade-plugins-升级插件)
* [Features (特色功能)](#features-特色功能)
	* [vim-plug](#vim-plug)
	* [Statusline (状态栏)](#statusline-状态栏)
	* [Shortcuts (快捷键)](#shortcuts-快捷键)
	* [Backup (备份路径)](#backup-备份路径)
	* [Template (模板)](#template-模板)
* [Plugins (插件列表)](#plugins-插件列表)
	* [php-manual](#php-manual)
	* [utime.vim](#utimevim)
* [Alternatives同类产品](#alternatives同类产品)
* [什么是vim,为什么要使用vim](#什么是vim为什么要使用vim)
	* [历史](#历史)
	* [帮助](#帮助)
	* [vim的五种模式](#vim的五种模式)
	* [vim的哲学](#vim的哲学)
	* [过渡阶段](#过渡阶段)
* [让vim cover日常的操作先](#让vim-cover日常的操作先)
	* [打开](#打开)
	* [浏览文件和文件切换](#浏览文件和文件切换)
	* [补全](#补全)
	* [移动](#移动)
	* [搜索](#搜索)
	* [复制,粘贴](#复制粘贴)
	* [删除,剪切](#删除剪切)
	* [编辑](#编辑)
	* [保存,退出](#保存退出)
* [vim的一些高级用法](#vim的一些高级用法)
	* [很强大的拖动功能](#很强大的拖动功能)
	* [转换文件编码和格式](#转换文件编码和格式)
	* [折叠](#折叠)
	* [分割窗口](#分割窗口)
	* [backup swap undo](#backup-swap-undo)
	* [一些vim命令行](#一些vim命令行)
	* [宏](#宏)
	* [必装插件](#必装插件)
	* [vim&md来解决问题的一些工具](#vimmd来解决问题的一些工具)
* [一些资源](#一些资源)
	* [拥有你自己的vimrc](#拥有你自己的vimrc)
	* [vim资源](#vim资源)
	* [一些我自己不用的方法](#一些我自己不用的方法)

<!-- vim-markdown-toc -->

## Install (安装)

    mv ~/.vim{,_bak}
    git clone https://github.com/mrytsr/vim-vide.vim ~/.vim
    tar xvf ~/.vim/vimplug.tgz -C ~

## Upgrade Plugins (升级插件)

    vim +PlugClean[!] +PlugUpdate +qa

## Features (特色功能)

### vim-plug

Base on vim-plug, A minimalist Vim plugin manager.
新一代的vim配置管理组件，体积最小，plugit用了并行下载，速度较顺序下载的vundle快很多！！！

https://github.com/junegunn/vim-plug

### Statusline (状态栏)

Origin vim config statusline, much faster than airline or powerline!
(vim原生配置实现的状态栏，信息很全，比airline或者powerline快数倍！！！)

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
- 撤销文件夹 ~/.vimtmp/undodir
- 备份文件夹 ~/.vimtmp/backupdir
- 交换文件夹 ~/.vimtmp/directory .swp files

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

## Alternatives同类产品

spf13/spf13-vim: The ultimate vim distribution
https://github.com/spf13/spf13-vim

wklken/k-vim: vim配置
https://github.com/wklken/k-vim

## 什么是vim,为什么要使用vim

### 历史

        ed -> ex(sed) -> vi -> vim -> gvim / macvim

### 帮助

        vimtutor
        :h - 帮助系统

### vim的五种模式

        插入模式 - 和普通编辑器的模式差不多
        普通模式
        可视模式
        命令行模式 - 扩展vim的功能,vim的精髓所在
        选择模式 - 不常用

### vim的哲学

        执行次数 + 操作 + 范围
         次数 1,2,3
         操作 v d c
         范围 a i w p $ " ' { ( [ t

         ni hao tang jun xin
         $('nihao')
         <a href="xx" >kjkjk </a>
 
### 过渡阶段

        让滚轮可用
        :set mouse=a

## 让vim cover日常的操作先

### 打开

        :e
        vim a.php b.php

### 浏览文件和文件切换

        :args
        :buffers(b)
        ctrl-6 - 在当前和上一个文件之间切换,有点像alt-tab

### 补全

        ctrl-p - 往前搜索的
        ctrl-n - 往后搜索补全
        ctrl-e - 取消,esc也可以
        ctrl-y - 确认,回车也可以

        更多: vi/vim使用进阶: 自动补全 – 易水博客
        http://easwy.com/blog/archives/advanced-vim-skills-auto-complete/

### 移动

        :59<cr> / 59G - 跳到第59行
        ^ / $ / 0 - 行首,行尾

        o / O - 插入上一行,插入下一行
        i / I - 查到前一个字符,行首
        w / W - 下一个单词
        b / B - 上一个单词
        e / E - 下一个单词尾
        ctrl-o / ctro-i
        gg / G / NUM G 跳到第一行,最后一行,NUM行
        {} - 段落跳转,以空行为
        M / H / L - 屏幕,中,上,下
        ma / mA - 标记mark为a,当前文件,全局

### 搜索

        f / F - 当前行搜索,til,正向,反向
        t / T - 当前行搜索,until,正向,反向
        ; / , - 重复当前行搜索
        / / ? - 当前文件搜索,向下,向上
        :grep -r / :!grep -r 跨文件搜索

### 复制,粘贴

        y
        shift-insert
        ctrl-r 0 / "
        p / P 粘贴到下面,上面

### 删除,剪切

        x / X
        d / D / dd

### 编辑

        c / C 修改
        s / S 替换,当前
        r / R 替换,当前字符,持续
        = - 格式化代码

### 保存,退出

        :w / :w!
        :q / :q!
        ZZ = :wq
        :wqa!

## vim的一些高级用法

### 很强大的拖动功能

        zz
        zt
        zb

### 转换文件编码和格式

        :set fileformat unix dos mas - 让换行符自由切换
        :set fileencodings - 检测打开文档编码的顺序,一般设置为utf-8,cp936
        :set fileencoding - 保存文档的编码,一般为utf-8
        :set encoding - vim本身界面的编码,一般和文档无关

### 折叠

        zf - 创建折叠
        zc - 关闭折叠
        zo - 打开折叠
        :mkview / :loadview - 保存,载入绘画

### 分割窗口

        :split
        :vsplit

### backup swap undo

### 一些vim命令行

        :'<,'>w !
        :make
        :X        - 加密
        :r        - 载入文件
        :s///gc
        :!sort    - 命令行过滤
        :normal / :global - 非常强大,但是本人不常用

### 宏

        qa - 录制到a
        @a - 播放
        导出和导入宏的方法

### 必装插件

        vim-phpmanual - php文档<s-k>查询
        syntastic - 语法检查
        ctrlp.vim - 文件跳转
        nerdtree - 浏览文件
        vim-gitgutter - 观察git状态
        vim-commentary - 强大的注释插件

### vim&md来解决问题的一些工具

        vs / notepad++ / elipse / idea / sublime - 都有相应的vim插件
        vimium - chrome
        ppt - pandoc
        博客 - pelican

## 一些资源

### 拥有你自己的vimrc

        spf13/spf13-vim https://github.com/spf13/spf13-vim
        mrytsr / tvim - Git@OSC - OSChina.Net http://git.oschina.net/mrytsr/tvim

        .vimrc
        /home/tjx/.vim/
        |-- autoload
        |  `-- pathogen.vim
        |-- bundle
        |  |-- ack.vim
        |  |-- vimproc.vim-master
        |  |-- vim-startify
        |  `-- xpt-0.4.8
        |-- tmp
        |  |-- backupdir
        |  |-- directory
        |  |-- NerdBookmarks.txt
        |  |-- undodir
        |  `-- view
        `-- vimrc

### vim资源

        Vimbits
        http://www.vimbits.com/

        简明 Vim 练级攻略 | 酷 壳 - CoolShell.cn
        http://coolshell.cn/articles/5426.html

        [翻译]130+vim基本命令
        http://wklken.me/posts/2013/08/17/130-essential-vim-commands.html#stq=&stp=0

        Vimer的程序世界 | 一个vim使用者的程序世界
        http://www.vimer.cn/

        Vim实用技巧 (豆瓣)
        https://book.douban.com/subject/25869486/

        welcome home : vim online
        http://www.vim.org/

        Vim | 易水博客
        http://easwy.com/blog/archives/tag/vim/

        Vimcasts - Free screencasts about the text editor Vim
        http://vimcasts.org/

        VimGolf - real Vim ninjas count every keystroke!
        http://vimgolf.com/

        Vim Awesome
        http://vimawesome.com/

### 一些我自己不用的方法

        用DBGPavim在Vim中调试PHP/Python程序
        https://brookhong.github.io/2014/09/27/dbgpavim-cn.html

        Cscope的使用（领略Vim + Cscope的强大魅力） - 面码的个人空间 - 开源中国社区
        http://my.oschina.net/u/572632/blog/267471

        VundleVim/Vundle.vim
        https://github.com/VundleVim/Vundle.vim

        Using tab pages - Vim Tips Wiki - Wikia
        http://vim.wikia.com/wiki/Using_tab_pages

        powerline / airline
