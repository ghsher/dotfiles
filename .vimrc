"Navigation"
set mouse=a

"Aesthetic"
set number
syntax on
colorscheme industry

"Indentation" 
set tabstop=4
set softtabstop=4 expandtab
set shiftwidth=4
set smarttab
set autoindent

"Splitting"
set splitbelow
set splitright

"Better undoing"
set undofile
set undodir=~/.vim/undodir

"Status Line"
"" Highlight modes
:hi CharColumn ctermbg=247 ctermfg=Black
:hi FileColumn ctermfg=White ctermbg=DarkGray
:hi ModeColumn cterm=reverse ctermbg=Black
":hi GitColumn  ctermfg=White ctermbg=245

"" Functions
"    function! GitBranch()
"       return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"    endfunction
"
"    function! StatuslineGit()
"       let l:branchname = GitBranch()
"       return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
"    endfunction

function! ChangeStatuslineModeColor()
    if (mode() =~# '\v(n|no)')
        exe 'hi! ModeColumn ctermfg=245'
    elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
        exe 'hi! ModeColumn ctermfg=005'
    elseif (mode() ==# 'i')
        exe 'hi! ModeColumn ctermfg=004'
    elseif (mode() ==# 'R')
        exe 'hi! ModeColumn ctermfg=045'
    else
        exe 'hi! ModeColumn ctermfg=006'
    endif
    return ''
endfunction

function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes/1024
    endif
    if (exists('kbytes') && kbytes >= 1024)
        let mbytes = kbytes/1000
    endif

    if (bytes <= 0)
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction

"" Mode Dictionary
let g:currentmode={
    \ 'n'      : 'N ',
    \ 'no'     : 'N·Operator Pending ',
    \ 'v'      : 'V ',
    \ 'V'      : 'V·Line ',
    \ ''     : 'V·Block ',
    \ 's'      : 'Select ',
    \ 'S'      : 'S·Line ',
    \ '\<C-S>' : 'S·Block ',
    \ 'i'      : 'I ',
    \ 'R'      : 'R ',
    \ 'Rv'     : 'V·Replace ',
    \ 'c'      : 'Command ',
    \ 'cv'     : 'Vim Ex ',
    \ 'ce'     : 'Ex ',
    \ 'r'      : 'Prompt ',
    \ 'rm'     : 'More ',
    \ 'r?'     : 'Confirm ',
    \ '!'      : 'Shell ',
    \ 't'      : 'Terminal '
    \}

set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineModeColor()}
set statusline+=%#ModeColumn#   " Mode information
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%#FileColumn#   " File information
set statusline+=\ %F                " file name
set statusline+=%m                  " modified tag
set statusline+=\ %y                " filetype
"set statusline+=\ %=
"set statusline+=%#GitColumn#
"set statusline+=%{StatuslineGit()}
set statusline+=\ %=
set statusline+=%-3(%{FileSize()}%)
set statusline+=%#CharColumn#
set statusline+=\ %l\:%c/%L\ [%p%%]\  
set statusline+=%#ModeColumn#   " Character location, %, etc.
set statusline+=\ 0x%B          " character byte value
set statusline+=\  
