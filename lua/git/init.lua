-- ~/.config/nvim/lua/git/init.lua

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

    -- 导航到 hunk
    vim.keymap.set('n', '<leader>gj', gs.next_hunk, 
      { buffer = bufnr, desc = 'Next git hunk' })
    vim.keymap.set('n', '<leader>gk', gs.prev_hunk, 
      { buffer = bufnr, desc = 'Previous git hunk' })
    
    -- Git blame 行操作
    vim.keymap.set('n', '<leader>gb', gs.blame_line, 
      { buffer = bufnr, desc = 'Git blame current line' })
    
    -- 启用全文件 blame 的快捷键
    vim.keymap.set('n', '<leader>gB', function()
      gs.blame_line { full = true }
    end, { buffer = bufnr, desc = 'Git blame (full file)' })
    
    -- 预览 hunk
    vim.keymap.set('n', '<leader>gp', gs.preview_hunk, 
      { buffer = bufnr, desc = 'Preview git hunk' })
    
    -- 其他有用的快捷键
    vim.keymap.set('n', '<leader>gu', gs.reset_hunk, 
      { buffer = bufnr, desc = 'Reset git hunk' })
    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, 
      { buffer = bufnr, desc = 'Stage git hunk' })
  end
}

-- 添加 Telescope Git 集成
-- 这部分在 gitsigns 配置后面添加
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', 
  { noremap = true, silent = true, desc = 'Git commits' })
vim.keymap.set('n', '<leader>gC', '<cmd>Telescope git_bcommits<CR>', 
  { noremap = true, silent = true, desc = 'Git commits for current buffer' })
vim.keymap.set('n', '<leader>gt', '<cmd>Telescope git_status<CR>', 
  { noremap = true, silent = true, desc = 'Git status' })
vim.keymap.set('n', '<leader>gB', '<cmd>Telescope git_branches<CR>', 
  { noremap = true, silent = true, desc = 'Git branches' })

-- 简化版：打开当前行的 commit 在 GitLab 中的链接
local function open_git_commit_link()
  -- 获取当前行的 commit hash
  local line = vim.fn.line('.')
  local file_path = vim.fn.expand('%:p')
  local blame_cmd = string.format('git -C %s blame -L %d,%d --porcelain %s', 
                                 vim.fn.shellescape(vim.fn.expand('%:p:h')),
                                 line, line, 
                                 vim.fn.shellescape(vim.fn.expand('%:t')))
  local blame_output = vim.fn.system(blame_cmd)
  local commit_hash = string.match(blame_output, "^(%x+)")
  
  if not commit_hash or commit_hash == "" then
    vim.notify("无法获取当前行的提交信息", vim.log.levels.ERROR)
    return
  end
  
  -- 获取 GitLab URL
  -- 修改这里为你的 GitLab 实例 URL
  local gitlab_url = "https://cichang8.com"
  
  -- 获取项目路径
  local remote_url_cmd = 'git -C ' .. vim.fn.shellescape(vim.fn.expand('%:p:h')) .. ' remote get-url origin'
  local remote_url = vim.fn.system(remote_url_cmd):gsub('\n', '')
  
  -- 提取项目路径的增强版本
  local project_path
  if remote_url:match("@") then
    -- SSH 格式: git@gitlab.example.com:group/project.git
    project_path = remote_url:match("[^:]+:([^%s]+)%.git")
  elseif remote_url:match("https?://") then
    -- HTTPS 格式: https://gitlab.example.com/group/project.git
    project_path = remote_url:match("https?://[^/]+/([^%s]+)%.git")
  else
    -- 其他格式尝试
    project_path = remote_url:match("([^%s]+)%.git$")
  end
  
  if not project_path then
    vim.notify("无法解析项目路径", vim.log.levels.ERROR)
    return
  end
  
  -- 构建并打开链接
  local commit_url = gitlab_url .. "/" .. project_path .. "/-/commit/" .. commit_hash
  
  -- 根据操作系统打开浏览器
  local open_cmd
  if vim.fn.has('mac') == 1 then
    open_cmd = 'open '
  elseif vim.fn.has('unix') == 1 then
    open_cmd = 'xdg-open '
  elseif vim.fn.has('win32') == 1 then
    open_cmd = 'start ""'
  else
    vim.notify("不支持的操作系统", vim.log.levels.ERROR)
    return
  end
  
  vim.fn.system(open_cmd .. vim.fn.shellescape(commit_url))
  vim.notify("正在打开提交链接: " .. commit_hash:sub(1, 7), vim.log.levels.INFO)
end

-- 添加快捷键
vim.keymap.set('n', '<leader>gl', open_git_commit_link, 
  { noremap = true, silent = true, desc = '在 GitLab 中打开当前行的提交' }) 