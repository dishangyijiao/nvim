-- ~/.config/nvim/lua/plugins/init.lua
-- 简化的插件配置 (使用 Lazy.nvim)

return {
  -- 核心插件
  { "folke/lazy.nvim", tag = "stable" },
  
  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          -- 配置文件
          "lua", "vim", "vimdoc", "query", 
          -- 后端语言
          "c", "cpp", "python", "go", "java", "ruby", "rust",
          -- 前端语言
          "javascript", "typescript", "html", "css", "scss", "tsx", "json", "yaml",
          -- DevOps 工具
          "dockerfile", "terraform", "hcl", "yaml", "bash", "json", "jsonnet",
          -- 构建工具
          "cmake", "make"
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
      })
    end,
  },
  
  -- LSP支持
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  
  -- 调试支持
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },
  
  -- LSP 和 DAP 包管理
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "▲",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- 禁用自动安装，根据日志显示 npm 安装失败
        ensure_installed = { },
        -- 注意: 所有服务器均需手动安装
        -- 检查 npm 安装和网络连接后，可以通过以下命令安装：
        -- :MasonInstall html-lsp css-lsp bash-language-server
        -- :MasonInstall jsonls clangd gopls pyright rust-analyzer
        automatic_installation = false, -- 禁用自动安装
      })
    end,
  },
  -- 暂时禁用 mason-nvim-dap 以避免错误
  -- { 
  --   "jay-babu/mason-nvim-dap.nvim",
  --   dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  --   config = function()
  --     -- 空配置
  --   end,
  -- },
  
  -- 文件树
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          
          -- 自定义按键映射
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          
          -- 修复Enter键映射，确保它打开文件或目录
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
          
          -- 其他有用的键映射
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
          vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        end,
      })
    end,
  },
  
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "codedark",
          component_separators = { left = "", right = ""},
          section_separators = { left = "", right = ""},
        }
      })
    end,
  },
  
  -- Git支持
  { 
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  
  -- 文件查找
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local keymap = vim.keymap.set
      
      telescope.setup()
      
      keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "查找文件" })
      keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "查找文件 (Ctrl+P)" })
      keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "全局搜索" })
      keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "查找缓冲区" })
    end,
  },
  
  -- VSCode Dark主题（C/C++配置）- 高优先级加载
  {
    "tomasiser/vim-code-dark",
    lazy = false,
    priority = 1000,
    config = function()
      -- 配置主题选项
      vim.g.codedark_conservative = false  -- 保持代码高亮的鲜艳色彩
      vim.g.codedark_italics = true        -- 启用斜体
      vim.g.codedark_transparent = false   -- 禁用透明背景
      
      -- 应用主题
      vim.cmd([[colorscheme codedark]])
      
      -- 为C/C++设置特定的高亮
      vim.cmd([[
        augroup cpp_highlights
        autocmd!
        autocmd FileType c,cpp highlight cppSTLtype guifg=#569CD6
        autocmd FileType c,cpp highlight cppSTLnamespace guifg=#4EC9B0
        autocmd FileType c,cpp highlight cppSTLconstant guifg=#4FC1FF
        augroup END
      ]])
    end,
  },
}
