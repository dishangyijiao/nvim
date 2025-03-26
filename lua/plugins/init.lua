-- ~/.config/nvim/lua/plugins/init.lua

-- 检查 vim-plug 是否已安装
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.notify('vim-plug is not installed. Please install it first.', vim.log.levels.ERROR)
  return
end

-- 使用 vim-plug 安装插件
vim.cmd [[
call plug#begin(stdpath('data') . '/plugged')
" 插件列表
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/tokyonight.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" or                                , { 'branch': '0.1.x' }
Plug 'lewis6991/gitsigns.nvim'
call plug#end()
]]

-- 确保插件配置被正确加载
vim.cmd([[
  autocmd VimEnter * if len(filter(values(g:plugs), "!isdirectory(v:val.dir)")) | PlugInstall --sync | source $MYVIMRC | endif
]])

