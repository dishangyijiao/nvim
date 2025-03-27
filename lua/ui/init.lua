-- ~/.config/nvim/lua/ui/init.lua

-- 配置 VS Code Dark 主题的基本选项
vim.g.codedark_conservative = false  -- 保持代码高亮的鲜艳色彩
vim.g.codedark_italics = true        -- 启用斜体
vim.g.codedark_transparent = false   -- 禁用透明背景

-- 使用 pcall 安全地加载主题，失败时使用默认主题
local status_ok, _ = pcall(function()
  vim.cmd([[colorscheme codedark]])
end)

if not status_ok then
  vim.notify("找不到 codedark 主题，请确保已安装 tomasiser/vim-code-dark 插件", vim.log.levels.WARN)
  vim.notify("使用默认主题", vim.log.levels.INFO)
  vim.cmd([[colorscheme default]])
end

-- 配置状态栏
local status_lualine, lualine = pcall(require, 'lualine')
if status_lualine then
  lualine.setup {
    options = {
      theme = 'auto',  -- 使用 auto 自动适应当前主题
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
    }
  }
end

-- 配置文件树
local status_tree, nvim_tree = pcall(require, 'nvim-tree')
if status_tree then
  nvim_tree.setup {
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }
end

-- 配置 Treesitter
local status_ts, ts_configs = pcall(require, 'nvim-treesitter.configs')
if status_ts then
  ts_configs.setup {
    ensure_installed = { "lua", "ruby", "javascript", "typescript", "python", "go", "html", "css", "json", "cpp", "c" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    }
  }
end
