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
lspconfig.ts_ls.setup({
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
            definitions = true,
            references = true,
            hover = true,
            rename = true,
            symbols = true,
            flags = {
                debounce_text_changes = 150,
            }
        }
    }
}

-- Ruby
lspconfig.ruby_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- 2. 文件导航相关快捷键配置
-- 使用 vim.keymap.set 而不是旧的 vim.api.nvim_set_keymap
-- 添加 desc 字段来提供快捷键说明

-- 配置 Telescope 快捷键（最佳实践）
-- 使用 <cmd> 而不是 :，并且添加描述
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', 
  { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', 
  { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', 
  { noremap = true, silent = true, desc = "Live grep (search in all files)" })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', 
  { noremap = true, silent = true, desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', 
  { noremap = true, silent = true, desc = "Help tags" })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', 
  { noremap = true, silent = true, desc = "Document symbols" })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', 
  { noremap = true, silent = true, desc = "Find references" })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', 
  { noremap = true, silent = true, desc = "Document diagnostics" })
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>',
  { noremap = true, silent = true, desc = "Go to definitions (Telescope)" })

-- 使用 Rg 进行搜索（因为 LSP 跳转不工作）
vim.keymap.set('n', '<leader>rg', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('Rg ' .. word)
end, { noremap = true, silent = true, desc = "Rg search current word" })

-- FZF 快捷键
vim.keymap.set('n', '<leader>rl', ':Rg <C-R><C-W><CR>',
  { noremap = true, desc = "Rg search word under cursor" })
vim.keymap.set('n', '<leader>rf', ':Files<CR>',
  { noremap = true, desc = "FZF files" })
vim.keymap.set('n', '<leader>rb', ':Buffers<CR>',
  { noremap = true, desc = "FZF buffers" })
vim.keymap.set('n', '<leader>rh', ':History<CR>',
  { noremap = true, desc = "FZF file history" })
