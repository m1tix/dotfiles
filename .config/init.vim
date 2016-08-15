" Vundle
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'
Plugin 'joshdick/airline-onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
call vundle#end()

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_contrast_dark = 'medium'
set background=dark
let python_highlight_all=1
filetype plugin indent on
let g:onedark_termcolors=16
syntax on
colorscheme gruvbox


" Set relative numbers to the side
set relativenumber

" Mouse support
set mouse=c

" Search settings (ignore lowercase/highlight all search cases)
set hlsearch
set ic

" Powerline
set laststatus=2
set encoding=utf-8
 let g:airline_powerline_fonts = 1
   if !exists('g:airline_symbols')
     let g:airline_symbols = {}
   endif
   " unicode symbols
   let g:airline_left_sep = '»'
   let g:airline_left_sep = '▶'
   let g:airline_right_sep = '«'
   let g:airline_right_sep = '◀'
   let g:airline_symbols.crypt = '🔒'
   let g:airline_symbols.linenr = '␊'
   let g:airline_symbols.linenr = '␤'
   let g:airline_symbols.linenr = '¶'
   let g:airline_symbols.maxlinenr = '☰'
   let g:airline_symbols.maxlinenr = ''
   let g:airline_symbols.branch = '⎇'
   let g:airline_symbols.paste = 'ρ'
   let g:airline_symbols.paste = 'Þ'
   let g:airline_symbols.paste = '∥'
   let g:airline_symbols.spell = 'Ꞩ'
   let g:airline_symbols.notexists = '∄'
   let g:airline_symbols.whitespace = 'Ξ'
   " powerline symbols
   let g:airline_left_sep = ''
   let g:airline_left_alt_sep = ''
   let g:airline_right_sep = ''
   let g:airline_right_alt_sep = ''
   let g:airline_symbols.branch = ''
   let g:airline_symbols.readonly = ''
   let g:airline_symbols.linenr = ''
" Code Folding (install SimpyIFold if folds aint good)
set foldmethod=indent
set foldlevel=99

" Tab specific options
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround
set textwidth=79

" Indent settings
set autoindent
set smartindent

" Clipboard settings
set clipboard=unnamedplus

" Autoshit
au BufNewFile,Bufread config set filetype=conf

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Bindings
map <C-n> : NERDTreeToggle<CR>

" Creates new line without entering insert mode
nmap <S-Enter> O<ESC>
nmap <CR> o<Esc>

" Resets last search pattern
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" disable arrow keys to brake the bad habit!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

map <F5> :w<CR>:!python %<CR>
