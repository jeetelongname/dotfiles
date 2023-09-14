local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- settings -- this is all of the basic vim settings
local o = vim.o  -- global
local g = vim.g  -- global 2?
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local
local lazy = require 'lazy'

g.mapleader = ' '

lazy.setup {
   -- theme
   {
      'ntk148v/vim-horizon', -- my theme of choice
      lazy = false,
      priority = 1000,
      config = function() vim.cmd "colorscheme horizon" end,
   }, 
   {
      'itchyny/lightline.vim', -- that status bar at the bottom of the screen
      lazy = false,
      config = function()  
         g.lightline = {
            colorscheme = 'horizon';
            active = { left = { { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }}};
         component_function = { gitbranch = 'fugitive#head', };}
      end,
   },
   -- language support
   'sheerun/vim-polyglot', -- language support for the lazy
   'sherylynn/vim-elisp', -- what can I say except I enjoy living in sin
   'nvim-treesitter/nvim-treesitter',
   'nvim-orgmode/orgmode',
   "nvim-treesitter/playground",
   -- lang server's
   'neovim/nvim-lspconfig', -- all the completion
   'hrsh7th/nvim-compe',  -- for actual completion
   -- utilitys
   'mhinz/vim-startify', -- a nice start page
   'kana/vim-smartinput', -- auto close delimiters
   'Raimondi/delimitMate', -- auto close delimeter
   'ap/vim-css-color',  -- highlights colour values
   'Chiel92/vim-autoformat', -- thats enough <space> thank you very much
   'wellle/targets.vim', -- all the text objects
   {
      'nvim-telescope/telescope.nvim', tag = '0.1.3',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   -- snippets -- why should you type when you can get your minions to do it for you?
   -- use 'sirver/ultisnips' -- the engine
   'honza/vim-snippets', -- the coal (the actual snippets)

   -- tpope plugins -- he is an artist
   'tpope/vim-commentary', -- comment and uncomment things with ease
   'tpope/vim-endwise', -- adds end to languages that use end (like this one! (and ruby))
   'tpope/vim-eunuch', -- helpers for unix commands
   'tpope/vim-repeat', -- repeat plugin commands
   'tpope/vim-scriptease', -- when there's somthing strange, in the code? who ya going to call? 'K'
   'tpope/vim-surround', -- surround texobj's with all kinds of delimiters
   'tpope/vim-vinegar', -- netrw was is in dired need for an upgrade

   -- git
   'airblade/vim-gitgutter', -- get your mind out of the sidebar!
   'tpope/vim-fugitive', -- mostly for the nice branch in the modeline
   'TimUntersberger/neogit', -- emacs is dead, long live emacs!

   -- other stuff
   -- use 'aurieh/discord.nvim' -- whats the point in using vim if your not telling the world?
   opts = {
      defaults = {
         lazy = false, 
      },
   },
}


-- global options -- I could explain all of these but then again :h VAR exists...
vim.cmd 'syntax enable'
o.inccommand = "nosplit"
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 3
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

-- lsp configs -- for dat solid completion TODO: finish lsp config
local lspconfig = require('lspconfig')

o.completeopt = "menuone,noselect"

-- lsp's I don't really do much
lspconfig.pylsp.setup{} -- python
lspconfig.solargraph.setup{} -- ruby
lspconfig.texlab.setup{} -- latex

-- orgmode
local orgmode = require 'orgmode'
orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

-- neogit
local neogit = require "neogit"
neogit.setup {
   disable_hint = true
}

-- treesitter
require 'nvim-treesitter.configs'.setup {
   ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
   highlight = {
      enable = true,              -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
      -- Required for spellcheck, some LaTex highlights and
      -- code block highlights that do not have ts grammar
      additional_vim_regex_highlighting = {'org'},
   },
}

-- ui -- basic ui settings ------------------------------------------------------------
o.termguicolors = true
vim.cmd "highlight WinSeparator guibg=None "
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
-- g.discord_activate_on_enter = 1

-- and thats it. thats my config. This should hopefully prove to people a noob (that can code)
-- can configure neovim to a very usable state. if you want to read more of this config (and check me out)
-- https://github.com/jeetelongname/dotfiles is the place to look
