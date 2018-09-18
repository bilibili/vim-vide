" -- {{{
"
"          File:  php.vim
"        Author:  Alvan
"      Modifier:  Alvan
"      Modified:  2017-08-13
"   Description:  PHP Manual for Vim
"
" -- }}}
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_phpmanual")
    finish
endif
let b:did_ftplugin_phpmanual = 1

exec 'setlocal rtp+='.fnameescape(expand('<sfile>:h:h')).'/manual'
setlocal keywordprg=:help

if !exists("g:php_manual_online_search_shortcut")
    let g:php_manual_online_search_shortcut = '<C-h>'
endif

if !exists("g:php_manual_online_search_url_format")
    let g:php_manual_online_search_url_format = 'http://php.net/%s'
endif

if g:php_manual_online_search_shortcut != ''
    exec 'vnoremap <silent> <buffer> '.g:php_manual_online_search_shortcut.' y:call phpmanual#online#open(@@)<CR>'
    exec 'nnoremap <silent> <buffer> '.g:php_manual_online_search_shortcut.' :call phpmanual#online#open()<CR>'
endif
