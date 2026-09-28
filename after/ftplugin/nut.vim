" Tagbar configuration for Squirrel
" Use Python's kinds since we map .nut to Python in ctags
let g:tagbar_type_nut = {
    \ 'ctagstype': 'python',
    \ 'kinds': [
        \ 'i:imports:1',
        \ 'c:classes:0',
        \ 'f:functions:0',
        \ 'm:members:0',
        \ 'v:variables:0'
    \ ],
    \ 'sort': 0
\ }
