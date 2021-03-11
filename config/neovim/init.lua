-- the start of my nvim config
-- packer initalisation
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)


local use = require('packer').use
local packer = require('packer')
packer.startup(function()
   use {'wbthomason/packer.nvim', opt = true} 
   use 'ntk148v/vim-horizon'
   use 'itchyny/lightline.vim'
   use 'airblade/vim-gitgutter'
   use 'kana/vim-smartinput'
   use 'sheerun/vim-polyglot'
   use 'ap/vim-css-color'
   use 'tpope/vim-surround'
   use 'tpope/vim-commentary'
   use 'tpope/vim-scriptease'
   use 'TimUntersberger/neogit'
   use 'jreybert/vimagit'
   use 'sherylynn/vim-elisp' -- what can I say except I enjoy living in sin
end)

vim.api.nvim_exec(
  [[
let leader=' ' 
let g:lightline = {'colorscheme' : 'horizon'}
colorscheme horizon
syntax enable
set termguicolors

" lightline
""spaces and tabs
set tabstop=4 " 
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
set clipboard=unnamedplus
""Searching
set incsearch
set hlsearch
""Folding
set foldenable
set noshowmode
  ]], false
  )

