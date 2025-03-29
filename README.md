# Mac 开发环境配置指南

Mac 配置全栈开发和 DevOps 工作环境指南，包括终端工具、代码编辑器和 Neovim 配置。

## 开发环境设置

### 终端工具

#### WezTerm

WezTerm 是一个现代化跨平台 GPU 加速终端模拟器。

**安装方式**:
```bash
brew install --cask wezterm
```

**下载链接**: [https://wezfurlong.org/wezterm/installation.html](https://wezfurlong.org/wezterm/installation.html)

#### tmux

tmux 是一个终端复用器，允许在单个终端窗口中运行多个终端会话。

**安装方式**:
```bash
brew install tmux
```

**下载链接**: [https://github.com/tmux/tmux/wiki](https://github.com/tmux/tmux/wiki)

**tmux 配置安装**:

本仓库包含了一个优化的 tmux 配置文件，位于 `tmux.conf`。要安装这个配置，请执行以下命令：

```bash
# 复制配置文件到主目录
 cp ~/.config/nvim/tmux.conf ~/.tmux.conf

# 重新加载配置（如果 tmux 已经运行）
tmux source-file ~/.tmux.conf
```

**tmux 使用指南**:

启动新会话：
```bash
tmux
```

启动新会话并命名：
```bash
tmux new -s 会话名
```

加入已有会话：
```bash
tmux attach -t 会话名
```

列出所有会话：
```bash
tmux ls
```

**tmux 快捷键**:

所有快捷键都需要先按前缀键 `Ctrl+a`，然后再按相应的键。

| 快捷键              | 功能                        |
|--------------------------|-----------------------------|
| `Ctrl+a ?`              | 显示所有快捷键              |
| **窗格操作**           |                             |
| `Ctrl+a \|`             | 水平分割窗格                  |
| `Ctrl+a -`              | 垂直分割窗格                  |
| `Ctrl+a h/j/k/l`        | 左/下/上/右切换窗格 (Vim风格)   |
| `Ctrl+a H/J/K/L`        | 调整窗格大小                  |
| `Ctrl+a m`              | 切换同步模式(同时在多窗格输入)   |
| **窗口管理**           |                             |
| `Ctrl+a c`              | 创建新窗口                    |
| `Ctrl+a ,`              | 重命名窗口                    |
| `Ctrl+a n/p`            | 切换到下一个/上一个窗口         |
| `Ctrl+a 0-9`            | 切换到窗口 0-9                |
| `Ctrl+a </>`            | 向前/向后移动窗口               |
| **会话管理**           |                             |
| `Ctrl+a S`              | 新建/附加会话                  |
| `Ctrl+a X`              | 关闭当前会话                   |
| `Ctrl+a d`              | 分离当前会话（保持会话在后台运行）   |
| **复制模式**           |                             |
| `Ctrl+a [`              | 进入复制模式                   |
| `v` (复制模式中)          | 开始选择                      |
| `y` (复制模式中)          | 复制选择内容                   |
| `r` (复制模式中)          | 矩形选择模式                   |
| **其他**              |                             |
| `Ctrl+a r`              | 重新加载 tmux 配置文件           |

### 代码编辑器

#### Neovim

Neovim 是 Vim 的现代化分支，特别适合架构设计和代码阅读。

**安装方式**:
```bash
brew install neovim
```

**下载链接**: [https://neovim.io/](https://neovim.io/)

#### Cursor

Cursor 是一个 AI IDE，基于 VS Code 构建，特别适合日常开发。

**安装方式**:
```bash
brew install --cask cursor
```

**下载链接**: [https://cursor.sh/](https://cursor.sh/)

#### Windsurf

Windsurf 是一个新兴代理式 IDE，支持 Cascade 人工智能。

**安装方式**:
从官方网站下载 DMG 文件并安装。

**下载链接**: [https://www.windsurf.dev/](https://www.windsurf.dev/)

### 工作流环境设置

根据不同开发需求和个人偏好，可以组合使用以下工具：

1. **命令行开发**:
   - WezTerm 提供 GPU 加速和先进的终端功能
   - tmux 实现会话管理和适合长时间运行的工作流

2. **IDE 开发**:
   - Cursor: 对于需要完整 IDE 功能且想要 AI 编程辅助的大型项目
   - Windsurf: 新一代 AI 与代码的深度集成，适合快速原型开发
   
3. **文本编辑器开发**:
   - Neovim: 适合快速的代码导航、复杂的文本处理和远程服务器编辑
   - 使用场景: 当需要深入架构分析、大量代码导航或远程开发时特别有用

这些工具可以并行使用，根据具体任务选择最合适的工具。例如，可以在 WezTerm 中运行 tmux，同时使用 Neovim 进行代码编辑，而在需要更多 IDE 功能时切换到 Cursor 或 Windsurf。

## Neovim 开发环境配置

下面是全栈开发和 DevOps 工程师优化的 Neovim 配置，支持多种编程语言，使用 Lazy.nvim 作为插件管理器，并以 VSCode Dark C/C++ 主题为基础。

### 特点

- 使用 Lazy.nvim 管理所有插件（性能更优、懒加载）
- VSCode Dark C/C++ 主题优化配置
- 多语言 LSP 支持（C/C++, Python, Go, Rust, Java, Ruby, JavaScript, HTML, CSS 等）
- Telescope 文件和代码搜索
- 代码补全与智能提示
- Treesitter 高级语法高亮
- Git 集成
- 调试支持（DAP + UI）
- Mason 自动管理 LSP 和 DAP 服务

### 支持语言

#### 后端语言
- C/C++: 同时支持 LSP 和 DAP
- Python: 包括 Django 调试支持
- Go: 完整代码导航与调试
- Java: LSP 与专业调试器
- Ruby: solargraph 支持
- Rust: rust-analyzer 支持

#### 前端语言
- JavaScript/TypeScript: LSP 与调试
- HTML/CSS: 智能补全与提示
- JSON/YAML: 模式验证与格式化
#### DevOps 工具
- Kubernetes: YAML 智能提示与 K8s 资源模式验证
- Docker: Dockerfile 语法高亮与 docker-compose 文件验证
- Terraform: HCL 语法高亮、智能补全与资源验证
- Ansible: YAML Playbook 支持
- Bash: 语法高亮与静态分析

### 文件结构

- `init.lua` - 主配置文件
- `lua/plugins/init.lua` - 所有插件配置
- `lua/lsp/init.lua` - 多语言 LSP 配置
- `lua/git/init.lua` - Git 相关配置
- `lua/dap/init.lua` - 多语言调试配置

### 快捷键

#### 基本快捷键

- `<Space>` - Leader 键
- `,` - Local leader 键

#### Telescope 快捷键

| 键位         | 功能             |
|--------------|------------------|
| `<C-p>`      | 查找文件         |
| `<leader>ff` | 查找文件         |
| `<leader>fg` | 全局搜索         |
| `<leader>fb` | 查找缓冲区       |
| `<leader>fs` | 文档符号搜索     |
| `<leader>fr` | 查找引用         |
| `<leader>fd` | 查找诊断信息     |
| `<leader>gd` | 转到定义         |

#### Git 快捷键

| 键位         | 功能             |
|--------------|------------------| 
| `<leader>gj` | 下一个更改块      |
| `<leader>gk` | 上一个更改块      |
| `<leader>gb` | 当前行 blame     |
| `<leader>gp` | 预览更改块       |
| `<leader>gu` | 撤销更改块       |
| `<leader>gs` | 暂存更改块       |
| `<leader>gc` | Git 提交历史     |
| `<leader>gt` | Git 文件状态     |
| `<leader>gB` | Git 分支         |

#### 调试快捷键

| 键位           | 功能             |
|----------------|------------------|
| `<F5>`         | 继续调试         |
| `<F10>`        | 单步跳过         |
| `<F11>`        | 单步进入         |
| `<F12>`        | 单步跳出         |
| `<leader>b`    | 切换断点         |
| `<leader>bc`   | 添加条件断点      |
| `<leader>bl`   | 添加日志断点      |
| `<leader>dr`   | 打开调试REPL      |
| `<leader>dl`   | 运行上次调试      |
| `<leader>du`   | 切换调试UI       |

### 依赖说明

此配置使用 Mason 自动管理语言服务器和调试适配器的安装。第一次编辑某些语言时，相应的 LSP 服务器和 DAP 适配器将自动安装。

你可以通过运行 `:Mason` 命令手动管理这些工具。
