let leader=" "
"plugin manager"
call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'ntk148v/vim-horizon'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

let g:lightline = {'colorscheme' : 'horizon'}
colorscheme horizon
syntax enable
set termguicolors
set filetype=man
set ts=8
set fdm=indent
set nomodified nolist nonumber nomodifiable
