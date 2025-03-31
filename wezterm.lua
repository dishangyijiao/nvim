-- WezTerm 配置文件
-- 主要用于解决中文字符显示问题

local wezterm = require('wezterm')
local config = {}

-- 使用 wezterm.config_builder 可以自动填充默认值
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 配置字体，包括中文字体回退
config.font = wezterm.font_with_fallback({
  -- 主字体 (可根据个人喜好调整)
  { family = 'JetBrains Mono', weight = 'Regular' },
  -- 中文字体回退选项，按优先级排序
  { family = 'Heiti SC', weight = 'Regular' },
  { family = 'PingFang SC', weight = 'Regular' },
  { family = 'Hiragino Sans GB', weight = 'Regular' },
  { family = 'Songti SC', weight = 'Regular' },
})

-- 设置字体大小
config.font_size = 14.0

-- 设置 TERM 环境变量以改善 tmux 中的兼容性
config.term = 'xterm-256color'

-- 确保正确处理 UTF-8 编码
config.use_ime = true
config.enable_kitty_keyboard = true

-- 设置窗口填充以避免字符溢出
config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

-- 确保在 tmux 中能正确处理非 ASCII 字符
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- 返回配置
return config
