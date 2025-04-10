#!/bin/bash
# ~/.config/nvim/scripts/tmux/tmux-dev.sh
# 用于日常开发环境管理

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 项目配置文件
CONFIG_FILE="$HOME/.config/nvim/scripts/tmux/projects.conf"

# 如果配置文件不存在，创建默认配置
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << EOF
# 项目配置文件
# 格式: 项目名称=项目路径

# 示例项目
web=$HOME/projects/web
api=$HOME/projects/api
admin=$HOME/projects/admin
mobile=$HOME/projects/mobile
devops=$HOME/projects/devops
EOF
fi

# 加载项目配置
declare -A PROJECTS
while IFS='=' read -r key value || [ -n "$key" ]; do
    # 跳过注释和空行
    [[ $key =~ ^#.*$ ]] && continue
    [[ -z $key ]] && continue
    
    # 移除空格并存储配置
    key=$(echo $key | xargs)
    value=$(echo $value | xargs)
    PROJECTS[$key]=$value
done < "$CONFIG_FILE"

# 创建项目会话
create_project_session() {
    local project_name=$1
    local project_path=${PROJECTS[$project_name]}
    
    # 检查项目路径
    if [ ! -d "$project_path" ]; then
        echo -e "${RED}错误: 项目路径不存在: $project_path${NC}"
        return 1
    }
    
    # 检查会话是否已存在
    tmux has-session -t $project_name 2>/dev/null
    if [ $? = 0 ]; then
        echo -e "${BLUE}会话 '$project_name' 已存在${NC}"
        return 0
    }
    
    echo -e "${BLUE}创建会话 '$project_name'...${NC}"
    
    # 创建新会话
    tmux new-session -d -s $project_name -n editor -c $project_path
    
    # 配置窗口
    # 1. 编辑器窗口
    tmux send-keys -t $project_name:editor "nvim ." C-m
    
    # 2. 终端窗口（分屏）
    tmux split-window -h -t $project_name:editor -c $project_path
    tmux select-pane -t $project_name:editor.1
    
    # 3. Git 窗口
    tmux new-window -t $project_name -n git -c $project_path
    tmux send-keys -t $project_name:git "git status" C-m
    
    # 4. 服务器/工具窗口
    tmux new-window -t $project_name -n server -c $project_path
    
    # 返回第一个窗口
    tmux select-window -t $project_name:1
    
    echo -e "${GREEN}会话 '$project_name' 创建完成${NC}"
}

# 显示帮助信息
show_help() {
    echo -e "${BLUE}用法:${NC} $0 [命令] [项目名]"
    echo
    echo "命令:"
    echo "  list          - 列出所有项目"
    echo "  start [name]  - 启动指定项目的开发环境"
    echo "  startall     - 启动所有项目的开发环境"
    echo "  config       - 编辑项目配置文件"
    echo
    echo -e "${BLUE}可用的项目:${NC}"
    for proj in "${!PROJECTS[@]}"; do
        echo "  $proj = ${PROJECTS[$proj]}"
    done
}

# 启动所有项目
start_all_projects() {
    for proj in "${!PROJECTS[@]}"; do
        create_project_session $proj
    done
}

# 主命令处理
case $1 in
    "list")
        echo -e "${BLUE}可用的项目:${NC}"
        for proj in "${!PROJECTS[@]}"; do
            echo "  $proj = ${PROJECTS[$proj]}"
        done
        ;;
    "start")
        if [ -z "$2" ]; then
            echo -e "${RED}错误: 请指定项目名称${NC}"
            show_help
            exit 1
        fi
        if [ -z "${PROJECTS[$2]}" ]; then
            echo -e "${RED}错误: 未知的项目 '$2'${NC}"
            show_help
            exit 1
        fi
        create_project_session $2
        tmux attach -t $2
        ;;
    "startall")
        start_all_projects
        # 附加到第一个项目
        first_project=$(echo "${!PROJECTS[@]}" | cut -d' ' -f1)
        tmux attach -t $first_project
        ;;
    "config")
        ${EDITOR:-vim} "$CONFIG_FILE"
        ;;
    *)
        show_help
        ;;
esac
