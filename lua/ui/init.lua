-- ~/.config/nvim/lua/ui/init.lua

-- 配置主题
vim.cmd[[colorscheme tokyonight]]

-- 配置状态栏
require('lualine').setup {
    options = {
        theme = 'tokyonight',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    }
}

-- 配置文件树
require('nvim-tree').setup {
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
