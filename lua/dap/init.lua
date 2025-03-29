-- ~/.config/nvim/lua/dap/init.lua
-- 全格式开发调试配置

local dap = require('dap')
local dapui = require('dapui')

-- DAP UI 配置
dapui.setup()

-- 自动打开/关闭 UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- 核心调试快捷键
vim.keymap.set('n', '<F5>', dap.continue, { desc = '继续DAP' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = '单步跳过' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = '单步进入' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = '单步跳出' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = '切换断点' })
vim.keymap.set('n', '<leader>bc', function() 
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = '条件断点' })
vim.keymap.set('n', '<leader>bl', function() 
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = '记录断点' })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = '打开REPL' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '运行上次调试' })

-- 打开/关闭 UI
vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '切换调试UI' })

-- Python 配置
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return '/usr/bin/python3'
    end,
  },
  {
    type = 'python',
    request = 'launch',
    name = "Django",
    program = "${workspaceFolder}/manage.py",
    args = { 'runserver', '--noreload' },
    pythonPath = function()
      return '/usr/bin/python3'
    end,
  },
}

-- Go 配置
dap.adapters.go = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  }
}

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    program = '${file}'
  },
  {
    type = 'go',
    name = 'Debug Package',
    request = 'launch',
    program = '${fileDirname}'
  },
  {
    type = 'go',
    name = 'Attach',
    mode = 'local',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

-- JavaScript/TypeScript 配置
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}
dap.configurations.typescript = dap.configurations.javascript

-- C/C++ 配置
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp

-- Rust 配置
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- Java 配置
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Attach to the process",
    hostName = 'localhost',
    port = 5005,
  },
}
