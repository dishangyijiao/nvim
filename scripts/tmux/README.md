# tmux 与 Neovim 整合配置

本目录包含了适用于开发环境的 tmux 配置和管理脚本，使您能够高效管理开发工作流程。特别添加了 tmux 与 Neovim 之间的无缝切换功能。

## 功能特点

1. **会话持久化**：使用 tmux-resurrect 和 tmux-continuum 插件
   - 即使系统重启后，您的 tmux 会话布局和内容也能恢复
   - 自动保存 Neovim 会话

2. **无缝窗口导航**：在 Neovim 和 tmux 之间使用相同的快捷键进行导航
   - 使用 `Ctrl+h/j/k/l` 无缝切换窗格和编辑器窗口
   - 不需要考虑当前是在 tmux 窗格还是 Neovim 窗口中

3. **项目管理**：通过脚本快速启动开发环境
   - 针对不同项目自动创建预配置的 tmux 会话

## 安装与配置

### 初始化环境（新系统）

```bash
# 1. 运行设置脚本
./setup.sh
```

此脚本将：
- 安装 tmux（如果尚未安装）
- 配置 tmux.conf
- 安装必要的 tmux 插件（tmux-resurrect, tmux-continuum）
- 设置 vim-tmux-navigator 集成

### 配置项目

配置文件 `projects.conf` 定义了您的项目：

```bash
# 编辑项目配置
vim projects.conf
```

配置格式：
```
# 项目名称=项目路径
web=$HOME/projects/web
api=$HOME/projects/api
admin=$HOME/projects/admin
```

## 日常使用

### 管理 tmux 会话

```bash
# 查看可用项目
./tmux-dev.sh list

# 启动特定项目会话
./tmux-dev.sh start web

# 启动所有项目会话
./tmux-dev.sh startall
```

### 窗口导航快捷键

**在 tmux 和 Neovim 之间无缝切换**：
- `Ctrl+h` - 切换到左侧窗格/窗口
- `Ctrl+j` - 切换到下方窗格/窗口
- `Ctrl+k` - 切换到上方窗格/窗口
- `Ctrl+l` - 切换到右侧窗格/窗口
- `Ctrl+\` - 切换到上一个窗格/窗口

**会话保存与恢复**：
- `prefix + Ctrl+s` - 保存会话（默认前缀键是 `Ctrl+a`）
- `prefix + Ctrl+r` - 恢复会话

### 其他 tmux 快捷键

**会话**：
- `prefix + s` - 选择会话
- `prefix + $` - 重命名会话
- `prefix + d` - 分离会话

**窗口**：
- `prefix + c` - 创建窗口
- `prefix + n` - 下一个窗口
- `prefix + p` - 上一个窗口
- `prefix + &` - 关闭窗口

**窗格**：
- `prefix + |` - 垂直分割
- `prefix + -` - 水平分割
- `prefix + x` - 关闭窗格

## 故障排除

如果遇到插件问题：

```bash
# 手动安装 tmux 插件
~/.tmux/plugins/tpm/bin/install_plugins

# 确保权限正确
chmod +x ~/.tmux/plugins/tpm/tpm
chmod +x ~/.tmux/plugins/tpm/bin/*

# 重新加载 tmux 配置
tmux source-file ~/.tmux.conf
```

如果 Neovim 与 tmux 导航集成不工作：

1. 确保在 Neovim 中安装了 vim-tmux-navigator 插件
2. 检查 `~/.config/nvim/lua/plugins/init.lua` 中是否有相关配置
3. 重启 tmux 和 Neovim 