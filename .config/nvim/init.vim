let leader=" " 
"plugin manager"
call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'psliwka/vim-smoothie'
Plug 'ntk148v/vim-horizon'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
call plug#end()

syntax enable

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
""Searching
set incsearch
set hlsearch
""Folding
set foldenable
""Airline
let g:airline_powerline_fonts = 1 
let g:airline_theme='bubblegum'
""Neotree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
