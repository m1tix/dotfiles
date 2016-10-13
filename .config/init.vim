" Vundle
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" General Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
" Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'Shougo/deoplete.nvim'
Plugin 'zchee/deoplete-jedi'
Plugin 'Rip-Rip/clang_complete'
Plugin 'Shougo/neco-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'PotatoesMaster/i3-vim-syntax'

" Colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'
Plugin 'rakr/vim-two-firewatch'
Plugin 'alessandroyorba/sierra'
Plugin 'jacoborus/tender'
Plugin 'chriskempson/base16-vim'
Plugin 'baskerville/bubblegum'

call vundle#end()

filetype plugin indent on
" Colors
set termguicolors
set background=dark
let python_highlight_all=1
let base16colorspace=256
syntax on
colorscheme base16-ocean
hi Nontext guifg=#2b303b

" Set relative numbers to the side
set relativenumber
set number

" Mouse support
set mouse=c

" Search settings (ignore lowercase/highlight all search cases)
set hlsearch
set ic

" Bar shit
set nosmd
set noru

" Powerline
set laststatus=2
set encoding=utf-8

" Lightline
let g:lightline = {
    \ 'colorscheme': 'ocean',
    \ 'active': {
    \   'left': [ [ 'mode' ],
    \             [ 'filetype' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'filename', 'syntastic' ] ],
    \ },
    \ 'component_expand': {
    \       'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \       'syntastic': 'middle',
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' },
    \ }

function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction
augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost * call s:syntastic()
augroup END

" Deoplete
set completeopt-=preview
let g:deoplete#enable_at_startup=1
let g:clang_library_path='/usr/lib/libclang.so'
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Terminal Emulator ColorScheme
let g:terminal_color_0 = "#2b303b"
let g:terminal_color_8 = "#65737e"
let g:terminal_color_1 = "#bf616a"
let g:terminal_color_9 = "#bf616a"
let g:terminal_color_2 = "#a3be8c"
let g:terminal_color_10 = "#a3be8c"
let g:terminal_color_3 = "#ebcb8b"
let g:terminal_color_11 = "#ebcb8b"
let g:terminal_color_4 = "#8fa1b3"
let g:terminal_color_12 = "#8fa1b3"
let g:terminal_color_5 = "#b48ead"
let g:terminal_color_13 = "#b48ead"
let g:terminal_color_6 = "#96b5b4"
let g:terminal_color_14 = "#96b5b4"
let g:terminal_color_7 = "#c0c5ce"
let g:terminal_color_15 = "#eff1f5"


" Code Folding (install SimpyIFold if folds aint good)
set foldmethod=indent
set foldlevel=99

" Tab specific options
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

au FileType python setl sw=4 sts=4 ts=8 tw=79

" Indent settings
set autoindent
set smartindent

" Clipboard settings
set clipboard=unnamedplus

" Autoshit
au BufNewFile,Bufread config set filetype=conf
" autocmd VimEnter * Goyo

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Creates new line without entering insert mode
nmap <S-Enter> O<ESC>
nmap <CR> o<Esc>

" Resets last search pattern
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" disable arrow keys to break the bad habit!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Python test shit
map <F5> :w<CR>:!python %<CR>

" remap split keybindings
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Quits nvim even if Goyo is active
let g:goyo_width='80%'
let g:goyo_height='90%'

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  set relativenumber
  set number
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
