if exists("g:loaded_MarkdownTocPlugin")
    finish
elseif v:version < 704
    finish
endif

let g:loaded_MarkdownTocPlugin = 1

if !exists("g:vmt_auto_update_on_save")
    let g:vmt_auto_update_on_save = 1
endif

if !exists("g:vmt_dont_insert_fence")
    let g:vmt_dont_insert_fence = 0
endif

if !exists("g:vmt_list_item_char")
    let g:vmt_list_item_char = '*'
endif

if !exists("g:vmt_list_indent_text")
    let g:vmt_list_indent_text = ''
endif

if !exists("g:vmt_cycle_list_item_markers")
    let g:vmt_cycle_list_item_markers = 0
endif

let g:GFMHeadingIds = {}

function! s:HeadingLineRegex()
    return '\v(^.+$\n^\=+$|^.+$\n^\-+$|^#{1,6})'
endfunction

function! s:GetSections(beginRegex, endRegex)
    let l:winview = winsaveview()
    let l:sections = {}

    normal! gg
    let l:flags = "Wc"
    let l:beginLine = 0
    let l:regex = a:beginRegex
    while search(l:regex, l:flags)
        let l:lineNum = line(".")
        if l:beginLine == 0
            let l:beginLine = l:lineNum
            let l:regex = a:endRegex
        else
            let l:sections[l:beginLine] = l:lineNum
            let l:beginLine = 0
            let l:regex = a:beginRegex
        endif
        let l:flags = "W"
    endwhile

    call winrestview(l:winview)

    return l:sections
endfunction

function! s:GetCodeSections()
    let l:codeSections = {}

    call extend(l:codeSections, <SID>GetSections("^```", "^```"))
    call extend(l:codeSections, <SID>GetSections("^{% highlight", "^{% endhighlight"))

    return l:codeSections
endfunction

function! s:IsLineInCodeSections(codeSections, lineNum)
    for beginLine in keys(a:codeSections)
        if a:lineNum >= str2nr(beginLine)
            if a:lineNum <= a:codeSections[beginLine]
                return 1
            endif
        endif
    endfor

    return 0
endfunction

function! s:GetHeadingLines()
    let l:winview = winsaveview()
    let l:headingLines = []
    let l:codeSections = <SID>GetCodeSections()

    let l:headingLineRegex = <SID>HeadingLineRegex()
    let l:flags = "W"

    while search(l:headingLineRegex, l:flags) != 0
        let l:line = getline(".")
        let l:lineNum = line(".")
        if <SID>IsLineInCodeSections(l:codeSections, l:lineNum) == 0
            " === compatible with Setext Style headings
            let l:nextLine = getline(l:lineNum + 1)
            if matchstr(l:nextLine, '\v^\=+$') != ""
                let l:line = "# " . l:line
            elseif matchstr(l:nextLine, '\v^\-+$') != ""
                let l:line = "## " . l:line
            endif
            " ===

            call add(l:headingLines, l:line)
        endif
    endwhile

    call winrestview(l:winview)

    return l:headingLines
endfunction

function! s:GetHeadingLevel(headingLine)
    return match(a:headingLine, '[^#]')
endfunction

function! s:GetHeadingLinkGFM(headingName)
    let l:headingLink = tr(a:headingName, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz")

    " \_^ : start of line
    " _\+ : one of more underscore _
    " \| : OR
    " _\+ : one of more underscore _
    " \_$ : end of line
    let l:headingLink = substitute(l:headingLink, "\\_^_\\+\\|_\\+\\_$", "", "g")
    " Characters that are not alphanumeric, latin1 extended (for accents) and
    " chinese chars are removed.
    " \\%#=0: allow this pattern to use the regexp engine he wants. Having
    " `set re=1` in the vimrc could break this behavior. cf. issue #19
    let l:headingLink = substitute(l:headingLink, "\\%#=0[^[:alnum:]\u00C0-\u00FF\u0400-\u04ff\u4e00-\u9fbf _-]", "", "g")
    let l:headingLink = substitute(l:headingLink, " ", "-", "g")

    if l:headingLink ==# ""
        let l:nullKey = "<null>"
        if has_key(g:GFMHeadingIds, l:nullKey)
            let g:GFMHeadingIds[l:nullKey] += 1
            let l:headingLink = l:headingLink . "-" . g:GFMHeadingIds[l:nullKey]
        else
            let g:GFMHeadingIds[l:nullKey] = 0
        endif
    elseif has_key(g:GFMHeadingIds, l:headingLink)
        let g:GFMHeadingIds[l:headingLink] += 1
        let l:headingLink = l:headingLink . "-" . g:GFMHeadingIds[l:headingLink]
    else
        let g:GFMHeadingIds[l:headingLink] = 0
    endif

    return l:headingLink
endfunction

" suppport for GitLab, fork of GetHeadingLinkGFM
" it's dirty to copy & paste code but more clear for maintain
function! s:GetHeadingLinkGitLab(headingName)
    let l:headingLink = tr(a:headingName, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz")

    let l:headingLink = substitute(l:headingLink, "\\_^_\\+\\|_\\+\\_$", "", "g")
    let l:headingLink = substitute(l:headingLink, "\\%#=0[^[:alnum:]\u00C0-\u00FF\u0400-\u04ff\u4e00-\u9fbf _-]", "", "g")
    let l:headingLink = substitute(l:headingLink, " ", "-", "g")
    let l:headingLink = substitute(l:headingLink, "-\\{2,}", "-", "g")

    if l:headingLink ==# ""
        let l:nullKey = "<null>"
        if has_key(g:GFMHeadingIds, l:nullKey)
            let g:GFMHeadingIds[l:nullKey] += 1
            let l:headingLink = l:headingLink . "-" . g:GFMHeadingIds[l:nullKey]
        else
            let g:GFMHeadingIds[l:nullKey] = 0
        endif
    elseif has_key(g:GFMHeadingIds, l:headingLink)
        let g:GFMHeadingIds[l:headingLink] += 1
        let l:headingLink = l:headingLink . "-" . g:GFMHeadingIds[l:headingLink]
    else
        let g:GFMHeadingIds[l:headingLink] = 0
    endif

    return l:headingLink
endfunction

function! s:GetHeadingLinkRedcarpet(headingName)
    let l:headingLink = tolower(a:headingName)

    let l:headingLink = substitute(l:headingLink, "<[^>]\\+>", "", "g")
    let l:headingLink = substitute(l:headingLink, "&", "&amp;", "g")
    let l:headingLink = substitute(l:headingLink, "\"", "&quot;", "g")
    let l:headingLink = substitute(l:headingLink, "'", "&#39;", "g")

    let l:headingLink = substitute(l:headingLink, "[ \\-&+\\$,/:;=?@\"#{}|\\^\\~\\[\\]`\\*()%.!']\\+", "-", "g")
    let l:headingLink = substitute(l:headingLink, "-\\{2,}", "-", "g")
    let l:headingLink = substitute(l:headingLink, "\\%^[\\-_]\\+\\|[\\-_]\\+\\%$", "", "g")

    return l:headingLink
endfunction

function! s:GetHeadingName(headingLine)
    let l:headingName = substitute(a:headingLine, '^#*\s*', "", "")
    let l:headingName = substitute(l:headingName, '\s*#*$', "", "")

    let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]([^()]*)', '\1', "g")
    let l:headingName = substitute(l:headingName, '\[\([^\[\]]*\)\]\[[^\[\]]*\]', '\1', "g")

    return l:headingName
endfunction

function! s:GetHeadingLink(headingName, markdownStyle)
    if a:markdownStyle ==# "GFM"
        return <SID>GetHeadingLinkGFM(a:headingName)
    elseif a:markdownStyle ==# "Redcarpet"
        return <SID>GetHeadingLinkRedcarpet(a:headingName)
    elseif a:markdownStyle ==# "GitLab"
        return <SID>GetHeadingLinkGitLab(a:headingName)
    endif
endfunction

function! GetHeadingLinkTest(headingLine, markdownStyle)
    let l:headingName = <SID>GetHeadingName(a:headingLine)
    return <SID>GetHeadingLink(l:headingName, a:markdownStyle)
endfunction

function! s:GenToc(markdownStyle)
    let l:headingLines = <SID>GetHeadingLines()
    let l:levels = []
    let l:listItemChars = [g:vmt_list_item_char]

    let g:GFMHeadingIds = {}
    
    for headingLine in l:headingLines
        call add(l:levels, <SID>GetHeadingLevel(headingLine))
    endfor

    let l:minLevel = min(l:levels)

    if g:vmt_dont_insert_fence == 0
        put =<SID>GetBeginFence(a:markdownStyle)
    endif

    if g:vmt_cycle_list_item_markers == 1
        let l:listItemChars = ['*', '-', '+']
    endif

    let l:i = 0
    " a black line before toc
    if !empty(l:headingLines)
        put =''
    endif
    for headingLine in l:headingLines
        let l:headingName = <SID>GetHeadingName(headingLine)
        let l:headingIndents = l:levels[i] - l:minLevel
        let l:listItemChar = l:listItemChars[(l:levels[i] + 1) % len(l:listItemChars)]
        let l:headingLink = <SID>GetHeadingLink(l:headingName, a:markdownStyle)

        let l:heading = repeat(s:GetIndentText(), l:headingIndents)
        let l:heading = l:heading . l:listItemChar
        let l:heading = l:heading . " [" . l:headingName . "]"
        let l:heading = l:heading . "(#" . l:headingLink . ")"

        put =l:heading

        let l:i += 1
    endfor

    " a blank line after toc to avoid effect typo of content below
    put =''

    if g:vmt_dont_insert_fence == 0
        put =<SID>GetEndFence()
    endif
endfunction

function! s:GetIndentText()
    if !empty(g:vmt_list_indent_text)
        return g:vmt_list_indent_text
    endif
    if &expandtab
        return repeat(" ", &shiftwidth)
    else
        return "\t"
    endif
endfunction

function! s:GetBeginFence(markdownStyle)
    return "<!-- vim-markdown-toc " . a:markdownStyle . " -->"
endfunction

function! s:GetEndFence()
    return "<!-- vim-markdown-toc -->"
endfunction

function! s:GetBeginFencePattern()
    return "<!-- vim-markdown-toc \\([[:alpha:]]\\+\\) -->"
endfunction

function! s:GetEndFencePattern()
    return <SID>GetEndFence()
endfunction

function! s:UpdateToc()
    let l:winview = winsaveview()

    let l:totalLineNum = line("$")

    let [l:markdownStyle, l:beginLineNumber, l:endLineNumber] = <SID>DeleteExistingToc()

    if l:markdownStyle ==# ""
        echom "Cannot find existing toc"
    elseif l:markdownStyle ==# "Unknown"
        echom "Find unsupported style toc"
    else
        let l:isFirstLine = (l:beginLineNumber == 1)
        if l:beginLineNumber > 1
            let l:beginLineNumber -= 1
        endif

        if l:isFirstLine != 0
            call cursor(l:beginLineNumber, 1)
            put! =''
        endif

        call cursor(l:beginLineNumber, 1)
        call <SID>GenToc(l:markdownStyle)

        if l:isFirstLine != 0
            call cursor(l:beginLineNumber, 1)
            normal! "_dd
        endif

        " fix line number to avoid shake
        if l:winview['lnum'] > l:endLineNumber
            let l:diff = line("$") - l:totalLineNum
            let l:winview['lnum'] += l:diff
            let l:winview['topline'] += l:diff
        endif
    endif

    call winrestview(l:winview)
endfunction

function! s:DeleteExistingToc()
    let l:winview = winsaveview()

    normal! gg

    let l:tocBeginPattern = <SID>GetBeginFencePattern()
    let l:tocEndPattern = <SID>GetEndFencePattern()

    let l:markdownStyle = ""
    let l:beginLineNumber = -1
    let l:endLineNumber= -1

    let l:flags = "Wc"
    if search(l:tocBeginPattern, l:flags) != 0
        let l:beginLine = getline(".")
        let l:beginLineNumber = line(".")

        if search(l:tocEndPattern, l:flags) != 0
            let l:markdownStyle = matchlist(l:beginLine, l:tocBeginPattern)[1]
            if l:markdownStyle != "GFM" && l:markdownStyle != "Redcarpet" && l:markdownStyle != "GitLab"
                let l:markdownStyle = "Unknown"
            else
                let l:endLineNumber = line(".")
                execute l:beginLineNumber. "," . l:endLineNumber. "delete_"
            end
        else
            echom "Cannot find toc end fence"
        endif
    else
        echom "Cannot find toc begin fence"
    endif

    call winrestview(l:winview)

    return [l:markdownStyle, l:beginLineNumber, l:endLineNumber]
endfunction

command! GenTocGFM :call <SID>GenToc("GFM")
command! GenTocGitLab :call <SID>GenToc("GitLab")
command! GenTocRedcarpet :call <SID>GenToc("Redcarpet")
command! UpdateToc :call <SID>UpdateToc()
command! RemoveToc :call <SID>DeleteExistingToc()

if g:vmt_auto_update_on_save == 1
    autocmd BufWritePre *.{md,mdown,mkd,mkdn,markdown,mdwn} :silent! UpdateToc
endif
