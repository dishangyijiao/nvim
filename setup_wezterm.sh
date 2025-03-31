#!/bin/bash
# 该脚本用于设置 WezTerm 配置的符号链接
# 从 Neovim 配置目录到 WezTerm 配置目录

# 确保 WezTerm 配置目录存在
mkdir -p ~/.config/wezterm

# 创建符号链接，如果已存在则覆盖
ln -sf ~/.config/nvim/wezterm.lua ~/.config/wezterm/wezterm.lua

echo "WezTerm 配置符号链接设置完成！"
echo "现在您的 WezTerm 配置将从 Neovim 配置目录同步。"
