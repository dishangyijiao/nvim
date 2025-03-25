-- ~/.config/nvim/lua/lsp/init.lua

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 1. 首先设置 leader 键（这必须在所有快捷键配置之前）
vim.g.mapleader = " "  -- 将 leader 键设置为空格键（这是最常用的设置）
vim.g.maplocalleader = ","  -- 将 local leader 键设置为逗号（可选）

-- 基本的 LSP 配置
local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end

-- 配置补全
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- 配置语言服务器
-- 只启用已安装的语言服务器
-- Python (需要 pip install pyright)
-- lspconfig.pyright.setup{
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

-- TypeScript/JavaScript
lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Go (需要安装 gopls)
-- lspconfig.gopls.setup{
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

-- Ruby
lspconfig.solargraph.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "rbenv", "exec", "solargraph", "stdio" },
    root_dir = lspconfig.util.root_pattern(".git", ".ruby-version", "Gemfile"),
    settings = {
        solargraph = {
            diagnostics = true,
            completion = true,
            flags = {
                debounce_text_changes = 150,
            }
        }
    }
}

-- 2. 文件导航相关快捷键配置
-- 使用 vim.keymap.set 而不是旧的 vim.api.nvim_set_keymap
-- 添加 desc 字段来提供快捷键说明

-- 基础选项
local opts = { noremap = true, silent = true }

-- 文件导航
-- 浏览最近文件
vim.keymap.set('n', '<space>o', '<cmd>Telescope oldfiles<cr>', 
  { noremap = true, silent = true, desc = 'Browse recent files' })

-- 查找文件
vim.keymap.set('n', '<space>ff', '<cmd>Telescope find_files<cr>', 
  { noremap = true, silent = true, desc = 'Find files' })

-- 搜索文件内容
vim.keymap.set('n', '<space>fg', '<cmd>Telescope live_grep<cr>', 
  { noremap = true, silent = true, desc = 'Live grep' })

-- 查找缓冲区
vim.keymap.set('n', '<space>fb', '<cmd>Telescope buffers<cr>', 
  { noremap = true, silent = true, desc = 'Find buffers' })

-- 查找帮助标签
vim.keymap.set('n', '<space>fh', '<cmd>Telescope help_tags<cr>', 
  { noremap = true, silent = true, desc = 'Help tags' })

-- 如果你也想要 FZF 的快捷键（作为备选）
vim.keymap.set('n', '<space>fz', '<cmd>FZF<cr>', 
  { noremap = true, silent = true, desc = 'FZF finder' })

-- 文件历史
vim.keymap.set('n', '<space>h', '<cmd>History<cr>', 
  { noremap = true, silent = true, desc = 'File history (FZF)' })
