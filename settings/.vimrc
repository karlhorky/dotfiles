colorscheme codedark

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start

" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Highlight current line
set cursorline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode

" Set a highlighted column at:
" - 72 characters (git commit title) https://github.com/refined-github/refined-github/pull/7428#issuecomment-2163379618
" - 80 characters (git commit body)
let &colorcolumn="72,80"
