" =============================================================================
" Filename: autoload/lightline/colorscheme/ocean.vim
" Author: M1tix
" License: MIT License
" Last Change: 2016/09/07 12:23:38.
" =============================================================================
" Light color  = #4f5b66
" Darker bg-color = #343d46
let s:base3 = '#c0c5ce'
let s:base2 = '#bababa' 
let s:base1 = '#a0a0a0'
let s:base0 = '#909090'
let s:base00 = '#666666'
let s:base01 = '#4f5b66'
let s:base02 = '#343d46'
let s:base023 = '#303030'
let s:base03 = '#2b303b'
let s:red = '#bf616a'
let s:orange = '#d08770'
let s:yellow = '#ebcb8b'
let s:green = '#a3be8c'
let s:cyan = '#96b5b4'
let s:blue = '#8fa1b3'
let s:magenta = '#b48ead'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:red ], [ s:base1, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:red ], [ s:base1, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base03 ] ]
let s:p.insert.left = [ [ s:base02, s:green ], [ s:base1, s:base01 ] ]
let s:p.insert.right = [ [ s:base02, s:green ], [ s:base1, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:orange ], [ s:base1, s:base01 ] ]
let s:p.replace.right = [ [ s:base02, s:orange ], [ s:base1, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base1, s:base01 ] ]
let s:p.visual.right = [ [ s:base02, s:magenta ], [ s:base1, s:base01 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.left = [ [ s:base2, s:base01 ] ]
let s:p.tabline.tabsel = [ [ s:base2, s:base023 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base0 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base023 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base02 ] ]

let g:lightline#colorscheme#ocean#palette = lightline#colorscheme#fill(s:p)
