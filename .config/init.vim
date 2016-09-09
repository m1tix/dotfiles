" Vundle
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" General Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/goyo.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'Shougo/deoplete.nvim'
Plugin 'zchee/deoplete-jedi'
Plugin 'Shougo/neco-vim'

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
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
let python_highlight_all=1
let base16colorspace=256
syntax on
colorscheme base16-ocean
" colorscheme onedark

" Set relative numbers to the side
set relativenumber

" Mouse support
set mouse=c

" Search settings (ignore lowercase/highlight all search cases)
set hlsearch
set ic

" Bar shit
set nosmd
set noru

" Deoplete
let g:deoplete#enable_at_startup=1

" Powerline
set laststatus=2
set encoding=utf-8
let g:airline_powerline_fonts = 1
" let g:airline_left_sep=''
" let g:airline_right_sep=''
let g:airline_section_y=''

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

" Python test shit
map <F5> :w<CR>:!python %<CR>

" remap split keybindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Quits nvim even if Goyo is active
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
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
