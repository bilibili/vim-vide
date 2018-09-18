" == "acomment" == {{{
"
"          File:  online.vim
"        Author:  Alvan
"      Modifier:  Alvan
"      Modified:  2014-08-20
"   Description:  PHP online manual for Vim
"
" --}}}

func! phpmanual#online#open(...)
    let key = ''

    if a:0 < 1
        let mcs = '[a-zA-Z0-9_]'
        let str = getline(".")
        let col = col(".")
        let end = col("$")

        let num = col - 1
        while num >= 0
            if strpart(str, num, 1) !~ mcs
                break
            endif
            let l = num
            let num -= 1
        endw

        if !exists("l")
            echo 'manual.ERR: The current content under the cursor is not a keyword.'
            return
        endif

        let num = col - 1
        while num <= end
            if strpart(str, num, 1) !~ mcs
                break
            endif
            let r = num
            let num += 1
        endw

        let key = strpart(str, l, r-l+1)
    el
        let key = a:1
    en

    if key == ''
        echo 'manual.ERR: no online manual URL.'
        return
    en

    let url = printf(g:php_manual_online_search_url_format, substitute(key, '[\r\n]', '', 'g'))

    if has("win32") || has("win95") || has("win64") || has("win16")
        call system("explorer " . shellescape(url))
    elseif has("mac")
        call system('open ' . shellescape(url))
    else
        call system('xdg-open ' . shellescape(url))
    endif
endf

" vim:ft=vim:ff=unix:tabstop=4:shiftwidth=4:softtabstop=4:expandtab
" End of file : online.vim
