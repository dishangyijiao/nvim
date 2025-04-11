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
          
          -- 添加上下级目录导航快捷键
          -- 进入子目录 (J键)
          vim.keymap.set('n', 'J', function()
            local node = api.tree.get_node_under_cursor()
            if node.type == "directory" then
              -- 直接进入子目录
              api.node.open.edit(node)
              -- 如果是关闭的目录，这会打开它
              -- 如果已经打开，这会进入该目录
              if node.open then
                api.tree.change_root_to_node(node)
              end
            end
          end, opts('进入子目录'))
          
          -- 返回父目录 (K键)
          vim.keymap.set('n', 'K', function()
            -- 切换到父目录
            api.tree.change_root_to_parent()
          end, opts('返回父目录'))
          
          -- 更多快捷导航
          vim.keymap.set('n', 'H', api.tree.change_root_to_parent, opts('Up'))
          vim.keymap.set('n', 'L', api.tree.change_root_to_node, opts('CD'))
          
          -- 其他实用快捷键
          vim.keymap.set('n', 'R', api.tree.reload, opts('刷新'))
          vim.keymap.set('n', 'a', api.fs.create, opts('创建'))
          vim.keymap.set('n', 'd', api.fs.remove, opts('删除'))
          vim.keymap.set('n', 'r', api.fs.rename, opts('重命名'))
          vim.keymap.set('n', 'c', api.fs.copy.node, opts('复制'))
          vim.keymap.set('n', 'p', api.fs.paste, opts('粘贴'))
          vim.keymap.set('n', 'y', api.fs.copy.filename, opts('复制文件名'))
          vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('复制相对路径'))
          vim.keymap.set('n', '?', api.tree.toggle_help, opts('帮助'))
        end,
      })
      
      -- 添加打开文件树的快捷键
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = '切换文件树', noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fe', ':NvimTreeFindFile<CR>', { desc = '在文件树中定位当前文件', noremap = true, silent = true })
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
  
  -- Avante.nvim - 官方AI助手 (使用OpenAI/Claude等模型)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    enabled = true,
    opts = {
      -- 简化配置，只使用 anthropic 提供商
      provider = "anthropic",
      -- API 配置
      anthropic = {
        api_key = "", -- 需要填入你的 API 密钥
        model = "claude-3.5-sonnet",
        endpoint = "https://api.deerapi.com", -- 代理地址
      },
    },
    -- 简化构建过程
    build = function()
      if vim.fn.has("win32") == 1 then
        vim.fn.system("powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false")
      else
        vim.fn.system("make BUILD_FROM_SOURCE=false")
      end
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
      -- 简单的错误处理
      local ok, avante = pcall(require, "avante")
      if not ok then
        vim.notify("Avante 插件加载失败", vim.log.levels.WARN)
        return
      end
      
      -- 设置插件
      avante.setup(opts)
      
      -- 简化快捷键
      vim.keymap.set("n", "<leader>aa", function()
        vim.cmd("Avante")
      end, { desc = "打开 Avante" })
      
      vim.keymap.set("n", "<leader>ac", function()
        vim.cmd("AvanteChat")
      end, { desc = "打开 Avante 聊天" })
      
      vim.keymap.set("v", "<leader>a", function()
        vim.cmd("AvanteSelection")
      end, { desc = "将选中文本发送到 Avante" })
    end,
  },
  
  -- 备选 AI 助手插件 (如果 avante.nvim 无法安装，可以启用这个)
  {
    "jackMort/ChatGPT.nvim",
    enabled = false, -- 默认禁用，如果 avante.nvim 无法安装，可以将此设为 true，并将 avante.nvim 设为 false
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = nil,
        yank_register = "+",
        edit_with_instructions = {
          diff = false,
          keymaps = {
            close = "<C-c>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          welcome_message = "欢迎使用 ChatGPT! 有什么我可以帮助你的吗?",
          loading_text = "加载中...",
          question_sign = "🙂",
          answer_sign = "🤖",
          max_line_length = 120,
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-f>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
            draft_message = "<C-d>",
            toggle_settings = "<C-o>",
            toggle_message_role = "<C-r>",
            toggle_system_role_open = "<C-s>",
            stop_generating = "<C-x>",
          },
        },
        popup_input = {
          prompt = "  ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " 提示 ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " SYSTEM ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " ChatGPT ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        session_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " 会话 ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      })
      
      -- 设置快捷键
      vim.keymap.set("n", "<leader>gc", "<cmd>ChatGPT<CR>", { desc = "打开 ChatGPT" })
      vim.keymap.set("v", "<leader>g", "<cmd>ChatGPTRun<CR>", { desc = "使用 ChatGPT 处理选中内容" })
      vim.keymap.set("n", "<leader>ge", "<cmd>ChatGPTEditWithInstructions<CR>", { desc = "使用 ChatGPT 编辑" })
    end,
  },
}
