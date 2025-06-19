# Neovim & Tmux 配置

## Neovim 配置

### 安装
```bash
brew install neovim
cd ~/.config/
git clone git@github.com:dishangyijiao/nvim.git
nvim .
```

### 特性
- Lazy.nvim 插件管理
- VSCode Dark 主题
- 多语言 LSP 支持
- Telescope 文件搜索
- Git 集成
- 调试支持

### 快捷键
- Leader 键: `<Space>`
- 文件搜索: `<leader>ff` 或 `<C-p>`
- 全局搜索: `<leader>fg`
- 跳转定义: `gd`
- 查找引用: `gr`
- 文件树: `<leader>e`

## Tmux 配置

### 安装
```bash
brew install tmux
cp ~/.config/nvim/tmux.conf ~/.tmux.conf
```

### 会话恢复
配置了 tmux-resurrect 和 tmux-continuum 实现会话自动保存和恢复。

#### 使用方法
- 手动保存: `Ctrl+a Ctrl+s`
- 手动恢复: `Ctrl+a Ctrl+r`
- 自动保存: 每 10 分钟
- 自动恢复: 启动 tmux 时

### 快捷键
前缀键: `Ctrl+a`

- 水平分割: `Ctrl+a |`
- 垂直分割: `Ctrl+a -`
- 窗格导航: `Ctrl+a h/j/k/l`
- 创建窗口: `Ctrl+a c`
- 分离会话: `Ctrl+a d`

## 终端配置

使用 Ghostty 作为终端模拟器。

### 安装
从 [Ghostty 官网](https://ghostty.org/) 下载安装。