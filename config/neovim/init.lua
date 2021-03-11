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
   -- package managment
   use {'wbthomason/packer.nvim', opt = true} 

   -- theme
   use 'ntk148v/vim-horizon'
   use 'itchyny/lightline.vim'
   -- language support
   use 'sheerun/vim-polyglot'
   use 'sherylynn/vim-elisp' -- what can I say except I enjoy living in sin
   -- utilitys
   use 'kana/vim-smartinput'
   use 'ap/vim-css-color'
   use 'tpope/vim-surround'
   use 'tpope/vim-commentary'
   use 'tpope/vim-scriptease'
   use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
   -- git
   use 'airblade/vim-gitgutter'
   use 'tpope/vim-fugitive'
   use 'TimUntersberger/neogit'
   use 'jreybert/vimagit'
end)

local o = vim.o
local g = vim.g

g.mapleader = ' '

o.termguicolors = true
vim.cmd("colorscheme horizon")

g.lightline = { colorscheme = 'horizon'; active = { left = { { 'mode', 'paste' },
   { 'gitbranch', 'readonly', 'filename', 'modified' }}};
   component_function = { gitbranch = 'fugitive#head', };}

vim.o.tabstop = 4
o.expandtab = true
o.encoding = 'UTF-8'
o.relativenumber = true
o.number = true

vim.api.nvim_exec(
  [[
syntax enable
set nu
set relativenumber
""UI config
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

