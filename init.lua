-- ~/.config/nvim/init.lua

-- 设置 Neovim 环境
vim.opt.termguicolors = true  -- 启用 24 位颜色

-- 基本设置
vim.opt.number = true         -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号
vim.opt.expandtab = true     -- 使用空格而不是制表符
vim.opt.shiftwidth = 2       -- 缩进宽度为2
vim.opt.tabstop = 2          -- Tab宽度为2
vim.opt.smartindent = true   -- 智能缩进

-- 插件管理
require('plugins')           -- 加载插件配置

-- UI 配置（在 LSP 之前加载）
require('ui')               -- 加载界面配置

-- LSP 配置
pcall(require, 'lsp')       -- 加载 LSP 配置

-- 调试配置
pcall(require, 'dap')       -- 加载调试配置

