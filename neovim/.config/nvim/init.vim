let leader=" " 
"plugin manager"
call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'psliwka/vim-smoothie'
Plug 'ntk148v/vim-horizon'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-smartinput'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease'
Plug 'jreybert/vimagit'
call plug#end()

let g:lightline = {'colorscheme' : 'horizon'}
colorscheme horizon
syntax enable
set termguicolors

" lightline
""spaces and tabs
set tabstop=4
set expandtab
""UI config
set encoding=UTF-8
set relativenumber
set nu
set showcmd
set cursorline
set wildmenu
set showmatch
set laststatus=2
set ruler
""Searching
set incsearch
set hlsearch
""Folding
set foldenable
set noshowmode
