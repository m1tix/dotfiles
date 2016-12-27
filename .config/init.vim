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
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'Shougo/deoplete.nvim'
Plugin 'zchee/deoplete-jedi'
" Plugin 'Rip-Rip/clang_complete'
Plugin 'Shougo/neco-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'lervag/vimtex'

" Colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'
Plugin 'rakr/vim-two-firewatch'
Plugin 'alessandroyorba/sierra'
Plugin 'jacoborus/tender'
Plugin 'chriskempson/base16-vim'
Plugin 'baskerville/bubblegum'
Plugin 'cocopon/iceberg.vim'

call vundle#end()

filetype plugin indent on
" Colors
set termguicolors
set background=dark
let python_highlight_all=1
let base16colorspace=256
syntax on
colorscheme ocean
hi Nontext guifg=#2b303b
hi SignColumn guibg=guibg

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

" localleader for latex
let maplocalleader = "\\"

" no no no no no no no no no
set noswapfile

" Polyglot
let g:polyglot_disabled = ['latex']

" Syntastic
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "△"
hi SyntasticErrorSign guifg=#bf616a
hi SyntasticWarningSign guifg=#ebcb8b
hi link SyntasticErrorSign SignColumn
hi link SyntasticWarningSign SignColumn
hi link SyntasticStyleErrorSign SignColumn
hi link SyntasticStyleWarningSign SignColumn

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
    \ }}

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
" let g:clang_library_path='/usr/lib/libclang.so'
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Terminal Emulator ColorScheme

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
