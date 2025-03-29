-- ~/.config/nvim/lua/lsp/init.lua
-- 简化的 LSP 配置

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
-- JavaScript/TypeScript
lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
})

-- HTML/CSS
lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

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

-- Python
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
})

-- Go
lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

-- C/C++
lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
})

-- Rust
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- Java
lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Terraform
lspconfig.terraformls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Kubernetes/YAML
lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "/*docker-compose*.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
            format = { enabled = true },
            validate = true,
            completion = true,
        },
    },
})

-- Dockerfile
lspconfig.dockerls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- LSP相关的快捷键配置
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', 
  { noremap = true, silent = true, desc = "文档符号搜索" })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', 
  { noremap = true, silent = true, desc = "查找引用" })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', 
  { noremap = true, silent = true, desc = "文档诊断信息" })
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>',
  { noremap = true, silent = true, desc = "转到定义 (Telescope)" })
