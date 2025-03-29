-- ~/.config/nvim/lua/git/init.lua
-- 简化的 Git 配置

-- 配置 gitsigns.nvim
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- 核心 Git 快捷键
    vim.keymap.set('n', '<leader>gj', gs.next_hunk, { buffer = bufnr, desc = '下一个更改块' })
    vim.keymap.set('n', '<leader>gk', gs.prev_hunk, { buffer = bufnr, desc = '上一个更改块' })
    vim.keymap.set('n', '<leader>gb', gs.blame_line, { buffer = bufnr, desc = '当前行 blame' })
    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = '预览更改块' })
    vim.keymap.set('n', '<leader>gu', gs.reset_hunk, { buffer = bufnr, desc = '撤销更改块' })
    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = '暂存更改块' })
  end
}

-- Telescope Git 集成
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { noremap = true, silent = true, desc = 'Git 提交历史' })
vim.keymap.set('n', '<leader>gt', '<cmd>Telescope git_status<CR>', { noremap = true, silent = true, desc = 'Git 文件状态' })
vim.keymap.set('n', '<leader>gB', '<cmd>Telescope git_branches<CR>', { noremap = true, silent = true, desc = 'Git 分支' })
 