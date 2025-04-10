#!/bin/bash
# ~/.config/nvim/scripts/tmux/setup.sh
# 用于新环境的初始化设置

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始设置 tmux 环境...${NC}"

# 检查并安装 tmux（如果需要）
if ! command -v tmux &> /dev/null; then
    echo "tmux 未安装，正在安装..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install tmux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y tmux
    fi
fi

# 创建 tmux 配置目录
mkdir -p ~/.tmux/plugins

# 安装 TPM（Tmux Plugin Manager）
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "安装 Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 创建/更新 tmux 配置文件
cat > ~/.tmux.conf << 'EOF'
# 修改前缀键为 Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# 基础设置
set -g default-terminal "screen-256color"
set -g history-limit 20000
set -g buffer-limit 20
set -g mouse on
set -g base-index 1
setw -g pane-base-index 1

# 窗格分割
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Vim 风格窗格导航
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# 窗格大小调整
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# 复制模式使用 vi 键位
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection

# 插件
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# 插件配置
set -g @continuum-restore 'on'
set -g @continuum-save-interval '10'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'

# 初始化插件管理器（保持在配置文件末尾）
run '~/.tmux/plugins/tpm/tpm'
EOF

# 安装插件
~/.tmux/plugins/tpm/bin/install_plugins

echo -e "${GREEN}tmux 环境设置完成！${NC}"
echo -e "${BLUE}提示：${NC}"
echo "1. 使用 prefix + I 安装插件（如果需要）"
echo "2. 使用 prefix + Ctrl-s 保存会话"
echo "3. 使用 prefix + Ctrl-r 恢复会话"
echo "4. 运行 ./tmux-dev.sh 来管理开发环境"
