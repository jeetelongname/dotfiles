-- the start of my nvim config I have not used lua or neovim before this day
-- packer initalisation -- stolen from mjlbach

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


local packer = require('packer')
packer.startup(function()
   local use = packer.use
   -- package managment
   use {'wbthomason/packer.nvim', opt = true}  -- the package responsible for it all

   -- theme
   use 'ntk148v/vim-horizon' -- my theme of choice
   use 'itchyny/lightline.vim' -- that status bar at the bottom of the screen
   -- language support
   use 'sheerun/vim-polyglot' -- language support for the lazy
   use 'sherylynn/vim-elisp' -- what can I say except I enjoy living in sin
   use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
   }
   use "nvim-treesitter/playground"
   -- lang server's
   use 'neovim/nvim-lspconfig' -- all the completion
   use 'hrsh7th/nvim-compe'  -- for actual completion
   -- utilitys
   use 'mhinz/vim-startify' -- a nice start page
   use 'kana/vim-smartinput' -- auto close delimiters
   use 'Raimondi/delimitMate' -- auto close delimeter
   use 'ap/vim-css-color'  -- highlights colour values
   use 'Chiel92/vim-autoformat' -- thats enough <space> thank you very much
   use 'wellle/targets.vim' -- all the text objects
   use { 'nvim-telescope/telescope.nvim', -- search and select tool (very cool)
   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}

   -- snippets -- why should you type when you can get your minions to do it for you?
   use 'sirver/ultisnips' -- the engine
   use 'honza/vim-snippets' -- the coal (the actual snippets)

   -- tpope plugins -- he is an artist
   use 'tpope/vim-commentary' -- comment and uncomment things with ease
   use 'tpope/vim-endwise' -- adds end to languages that use end (like this one! (and ruby))
   use 'tpope/vim-eunuch' -- helpers for unix commands
   use 'tpope/vim-repeat' -- repeat plugin commands
   use 'tpope/vim-scriptease' -- when there's somthing strange, in the code? who ya going to call? 'K'
   use 'tpope/vim-surround' -- surround texobj's with all kinds of delimiters
   use 'tpope/vim-vinegar' -- netrw was is in dired need for an upgrade

   -- git
   use 'airblade/vim-gitgutter' -- get your mind out of the sidebar!
   use 'tpope/vim-fugitive' -- mostly for the nice branch in the modeline
   use 'TimUntersberger/neogit' -- emacs is dead, long live emacs! FIXME

   -- other stuff
   use 'aurieh/discord.nvim' -- whats the point in using vim if your not telling the world?
end)
-- settings -- this is all of the basic vim settings
local o = vim.o  -- global
local g = vim.g  -- global 2?
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local

-- global options -- I could explain all of these but then again :h VAR exists...
vim.cmd('syntax enable')
o.inccommand = "nosplit"
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.showcmd = true
o.wildmenu = true
o.mouse = 'a'
o.showmatch = true
o.expandtab = true
o.ruler = true
o.clipboard = 'unnamedplus'
o.incsearch = true
o.hlsearch = true
o.showmode = false
o.tabstop = 4
o.encoding = 'UTF-8'
o.timeout = false
o.timeoutlen = 10
-- window-local option
wo.number = true
wo.relativenumber = true
wo.wrap = false
wo.cursorline = true
wo.foldenable = true
-- buffer-local options
bo.expandtab = true

-- keys -- my keybinding scheme is pretty much a rip off of dooms keybinds (because its great!)
-- leader

g.mapleader = ' '
-- local opts = {noremap = true, silent = true}

function cmdM(cmd)
   return '<cmd> ' .. cmd .. ' <cr>'
end

function map(mode, keybind, func, opts)

   local key = vim.api.nvim_set_keymap
   local opts = opts or {noremap = true, silent = true}

   if mode == 'leader' then
      key('n', ('<leader>' .. keybind), cmdM(func), opts)
   else
      key(mode, keybind, cmdM(func), opts)
   end
end
--
-- misc
map('leader', '<space>', "lua require('telescope.builtin').find_files()")

-- git
-- open neogit (the second most sane way to interact with git)
map('leader', 'gg', 'Neogit')

-- buffer
-- open a list of all open buffers
map('leader', 'b', "lua require('telescope.builtin').buffers()")

-- search
-- search the currently open file
map('leader', 'sf', "lua require('telescope.builtin').current_buffer_fuzzy_find()")

-- window
-- vertical split
map('leader', 'wv', "vsplit")

-- horizontal split
map('leader', 'ws', "split")

-- close a window
map('leader', 'wc', "quit")

-- session
---- load the last session
map('leader', 'ql', "SLoad!")

-- save the current session
map('leader', 'qs', "SSave!")

-- open startify (home)
map('leader', 'qh', "Startify")

-- open
-- open dired.. I mean Explore
map('leader', 'o-',  "Explore")

-- code
map('leader', 'cf', 'Autoformat')

map('leader', 'hrc', 'luafile $XDG_CONFIG_HOME/nvim/init.lua')

-- file
map('leader', 'fs', 'write')

-- snippets -----------------------------------------------------
g.UltiSnipsExpandTrigger="<tab>" -- expand snippet on tab
g.UltiSnipsJumpForwardTrigger="<c-b>"
g.UltiSnipsJumpBackwardTrigger="<c-z>"

--  If you want :UltiSnipsEdit to split your window.
g.UltiSnipsEditSplit="vertical"
-- lsp configs -- for dat solid completion TODO: finish lsp config

local lspconfig = require('lspconfig')

o.completeopt = "menuone,noselect"

require'compe'.setup {
   enabled = true;
   autocomplete = true;
   debug = false;
   min_length = 1;
   preselect = 'enable';
   throttle_time = 80;
   source_timeout = 200;
   incomplete_delay = 400;
   max_abbr_width = 100;
   max_kind_width = 100;
   max_menu_width = 100;
   documentation = true;

   source = {
      path = true;
      buffer = false;
      calc = true;
      vsnip = false;
      nvim_lsp = true;
      nvim_lua = true;
      spell = true;
      tags = false;
      snippets_nvim = true;
   };
}

local custom_attach = function(client)
   print("LSP started.");
   require'completion'.on_attach(client)
   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, update_in_insert = false }
      )
   -- automatic diagnostics popup
   execute('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
   -- speedup diagnostics popup
   o.updatetime=1000


   vim.cmd("inoremap <silent><expr> <C-Space> compe#complete()") -- meant to complete on point
   key('n', 'gD',cmdM('lua vim.lsp.buf.declaration()'), opts) -- jump to definition
end

-- lsp's I don't really do much
lspconfig.pylsp.setup{} -- python
lspconfig.solargraph.setup{} -- ruby
lspconfig.texlab.setup{} -- latex

-- treesitter
require'nvim-treesitter.configs'.setup {
   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
   ignore_install = { "javascript" }, -- List of parsers to ignore installing
   highlight = {
      enable = true,              -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
   },
}
-- ui -- basic ui settings ------------------------------------------------------------
o.termguicolors = true
vim.cmd("colorscheme horizon")

-- custom lightline
g.lightline = {
   colorscheme = 'horizon';
   active = { left = { { 'mode', 'paste' },
   { 'gitbranch', 'readonly', 'filename', 'modified' }}};
component_function = { gitbranch = 'fugitive#head', };}

-- header of the start page
g.header = {
   '          ',
   '    _/_/_/',
   '   _/    _/    _/_/      _/_/    _/_/_/  _/_/',
   '  _/    _/  _/    _/  _/    _/  _/    _/    _/',
   ' _/    _/  _/    _/  _/    _/  _/    _/    _/',
   '_/_/_/      _/_/      _/_/    _/    _/    _/',
   '',
   '             _/  _/    _/',
   '            _/      _/_/_/_/    _/_/',
   '           _/  _/    _/      _/_/_/_/',
   '          _/  _/    _/      _/',
   '         _/  _/      _/_/    _/_/_/',
   '',
   '         wait, this is not emacs! ',
}

vim.cmd([[
   let g:startify_custom_header = startify#center(g:header)
]]) -- centers the startpage banner

-- misc stuff
g.discord_activate_on_enter = 1

-- and thats it. thats my config. This should hopefully prove to people a noob (that can code)
-- can configure neovim to a very usable state. if you want to read more of this config (and check me out)
-- https://github.com/jeetelongname/dotfiles is the place to look
