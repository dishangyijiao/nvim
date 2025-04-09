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

**WezTerm 配置安装**:

本仓库包含了适配中文字体显示的 WezTerm 配置文件，位于 `wezterm.lua`。要安装这个配置，请执行以下命令：

```bash
# 运行安装脚本创建符号链接
~/.config/nvim/setup_wezterm.sh
```

<details>
<summary><b>WezTerm 配置亮点</b></summary>

- **中文字体支持**: 配置了字体回退机制，确保中文字符在 tmux 和 Neovim 中正确显示
- **字体配置**: 使用 JetBrains Mono 作为主字体，回退到 Heiti SC、PingFang SC 等中文字体
- **终端兼容性**: 设置了 xterm-256color 终端类型，优化与 tmux 配合使用
- **UTF-8 支持**: 启用了必要的编码设置，确保各种语言字符正确显示

要修改配置，编辑 `~/.config/nvim/wezterm.lua` 文件即可，修改后重启 WezTerm 生效。
</details>

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

<details>
<summary><b>tmux 使用指南</b></summary>

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

</details>

### 代码编辑器

#### Neovim

Neovim 是 Vim 的现代化分支，特别适合架构设计和代码阅读。

**安装方式**:
```bash
brew install neovim
```
- 执行`cd ～/config/`，再执行 `git clone git@github.com:dishangyijiao/nvim.git`，用`nvim .`打开加载安全全部配置

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

<details>
<summary><b>特点</b></summary>

- 使用 Lazy.nvim 管理所有插件（性能更优、懒加载）
- VSCode Dark C/C++ 主题优化配置
- 多语言 LSP 支持（C/C++, Python, Go, Rust, Java, Ruby, JavaScript, HTML, CSS 等）
- Telescope 文件和代码搜索
- 代码补全与智能提示
- Treesitter 高级语法高亮
- Git 集成
- 调试支持（DAP + UI）
- Mason 自动管理 LSP 和 DAP 服务

</details>

<details>
<summary><b>支持语言</b></summary>

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

</details>

<details>
<summary><b>文件结构</b></summary>

- `init.lua` - 主配置文件
- `lua/plugins/init.lua` - 所有插件配置
- `lua/lsp/init.lua` - 多语言 LSP 配置
- `lua/git/init.lua` - Git 相关配置
- `lua/dap/init.lua` - 多语言调试配置

</details>

## 快捷键指南

### tmux 快捷键
<details>
<summary><b>基本快捷键</b></summary>

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

</details>

### Neovim 快捷键

<details>
<summary><b>基本快捷键</b></summary>

- `<Space>` - Leader 键
- `,` - Local leader 键

</details>

<details>
<summary><b>导航与移动</b></summary>

| 键位      | 功能                   |
|-----------|------------------------|  
| `h/j/k/l` | 左/下/上/右移动        |
| `w`       | 向前移动一个单词       |
| `b`       | 向后移动一个单词       |
| `e`       | 移动到单词结尾         |
| `0`       | 移动到行首            |
| `$`       | 移动到行尾            |
| `gg`      | 移动到文件开头        |
| `G`       | 移动到文件结尾        |
| `<n>G`    | 移动到第n行           |
| `:<n>`    | 移动到第n行           |
| `<n>j/k`  | 向下/上移动n行        |
| `<n>h/l`  | 向左/右移动n个字符    |
| `<n>w/b`  | 向前/后移动n个单词    |
| `H`       | 移动到屏幕顶部        |
| `M`       | 移动到屏幕中间        |
| `L`       | 移动到屏幕底部        |
| `zz`      | 将当前行置于屏幕中央  |
| `zt`      | 将当前行置于屏幕顶部  |
| `zb`      | 将当前行置于屏幕底部  |
| `Ctrl+d`  | 向下翻半页           |
| `Ctrl+u`  | 向上翻半页           |
| `Ctrl+f`  | 向下翻整页           |
| `Ctrl+b`  | 向上翻整页           |
| `%`       | 跳转到匹配的括号     |

</details>

<details>
<summary><b>编辑操作</b></summary>

| 键位      | 功能                      |
|-----------|---------------------------|  
| `i`       | 在光标前进入插入模式      |
| `I`       | 在行首进入插入模式        |
| `a`       | 在光标后进入插入模式      |
| `A`       | 在行尾进入插入模式        |
| `o`       | 在下方新行插入并进入插入模式 |
| `O`       | 在上方新行插入并进入插入模式 |
| `x`       | 删除光标下字符            |
| `dd`      | 删除整行                  |
| `<n>dd`   | 删除n行                   |
| `d<motion>` | 删除motion范围内文本      |
| `yy`      | 复制整行                  |
| `<n>yy`   | 复制n行                   |
| `y<motion>` | 复制motion范围内文本      |
| `p`       | 在光标后粘贴              |
| `P`       | 在光标前粘贴              |
| `"+y`     | 复制到系统剪贴板          |
| `"+p`     | 从系统剪贴板粘贴          |
| `u`       | 撤销上一次操作            |
| `Ctrl+r`  | 重做（撤销的撤销）        |
| `r<char>` | 替换当前字符              |
| `~`       | 切换大小写                |
| `>>`      | 增加缩进                  |
| `<<`      | 减少缩进                  |
| `:s/old/new/g` | 替换当前行所有匹配     |
| `:%s/old/new/g` | 替换整个文件所有匹配   |
| `:<n>,<m>s/old/new/g` | 替换从n到m行的所有匹配 |

</details>

<details>
<summary><b>查找与替换</b></summary>

| 键位      | 功能                     |
|-----------|--------------------------|  
| `/pattern` | 向前搜索pattern          |
| `?pattern` | 向后搜索pattern          |
| `n`       | 重复上次搜索（同方向）   |
| `N`       | 重复上次搜索（反方向）   |
| `*`       | 向前搜索光标下的单词     |
| `#`       | 向后搜索光标下的单词     |
| `:noh`    | 取消搜索高亮             |

</details>

<details>
<summary><b>Visual模式</b></summary>

| 键位      | 功能                     |
|-----------|--------------------------|  
| `v`       | 进入可视模式             |
| `V`       | 进入行可视模式           |
| `Ctrl+v`  | 进入块可视模式           |
| `>`       | 增加选中区域缩进         |
| `<`       | 减少选中区域缩进         |
| `y`       | 复制选中区域             |
| `d`       | 删除选中区域             |
| `c`       | 删除选中区域并进入插入模式 |
| `o`       | 移动到选择区域的另一端   |

</details>

<details>
<summary><b>窗口管理</b></summary>

| 键位          | 功能                 |
|---------------|----------------------|  
| `:sp`         | 水平分割窗口         |
| `:vs`         | 垂直分割窗口         |
| `Ctrl+w+h/j/k/l` | 切换到左/下/上/右窗口 |
| `Ctrl+w+H/J/K/L` | 移动窗口到左/下/上/右 |
| `Ctrl+w+=`    | 等分所有窗口         |
| `Ctrl+w+_`    | 最大化当前窗口高度   |
| `Ctrl+w+&#124;`    | 当前窗口的高度增加一行（更高）   |
| `:q`          | 关闭当前窗口         |
| `:qa`         | 关闭所有窗口         |

</details>

<details>
<summary><b>文件与缓冲区</b></summary>

| 键位       | 功能                   |
|------------|------------------------|  
| `:e file`  | 编辑文件               |
| `:w`       | 保存当前文件           |
| `:wa`      | 保存所有文件           |
| `:q`       | 退出                   |
| `:q!`      | 强制退出（不保存）     |
| `:wq`      | 保存并退出             |
| `:bn`      | 切换到下一个缓冲区     |
| `:bp`      | 切换到上一个缓冲区     |
| `:bd`      | 删除当前缓冲区         |
| `:ls`      | 列出所有缓冲区         |
| `:b<n>`    | 切换到第n个缓冲区      |

</details>

<details>
<summary><b>Telescope 快捷键</b></summary>

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

</details>

<details>
<summary><b>LSP 相关</b></summary>

| 键位         | 功能             |
|--------------|------------------|
| `gd`         | 转到定义         |
| `gr`         | 查找引用         |
| `K`          | 显示悬停信息     |
| `<leader>rn` | 重命名标识符     |
| `<leader>ca` | 代码操作         |
| `[d`         | 上一个诊断       |
| `]d`         | 下一个诊断       |
| `<leader>e`  | 显示行诊断       |
| `<leader>q`  | 显示诊断列表     |

</details>

<details>
<summary><b>Git 快捷键</b></summary>

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

</details>

<details>
<summary><b>调试快捷键</b></summary>

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

</details>

### 依赖说明

此配置使用 Mason 自动管理语言服务器和调试适配器的安装。第一次编辑某些语言时，相应的 LSP 服务器和 DAP 适配器将自动安装。

你可以通过运行 `:Mason` 命令手动管理这些工具。
