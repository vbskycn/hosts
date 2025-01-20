#!/bin/bash

# 定义颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 定义标记
START_MARK="# === ineo6 GitHub Host Start ==="
END_MARK="# === ineo6 GitHub Host End ==="

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}请使用 sudo 运行此脚本${NC}"
    exit 1
fi

# 定义 hosts 文件路径
HOSTS_FILE="/etc/hosts"
HOSTS_BACKUP="/etc/hosts.backup.$(date +%Y%m%d_%H%M%S)"

# 解析命令行参数
if [ "$1" = "--remove" ]; then
    # 删除现有的 GitHub hosts 配置
    if grep -q "$START_MARK" "$HOSTS_FILE"; then
        # 创建备份
        cp "$HOSTS_FILE" "$HOSTS_BACKUP"
        echo -e "${GREEN}已创建 hosts 文件备份: $HOSTS_BACKUP${NC}"
        
        # 删除标记之间的内容
        sed -i "/$START_MARK/,/$END_MARK/d" "$HOSTS_FILE"
        echo -e "${GREEN}已成功删除 GitHub hosts 配置${NC}"
        
        # 刷新 DNS 缓存
        if command -v systemd-resolve >/dev/null 2>&1; then
            systemd-resolve --flush-caches
        elif command -v systemctl >/dev/null 2>&1; then
            systemctl restart systemd-resolved
        fi
    else
        echo -e "${YELLOW}未找到现有的 GitHub hosts 配置${NC}"
    fi
    exit 0
fi

# 创建备份
cp "$HOSTS_FILE" "$HOSTS_BACKUP"
echo -e "${GREEN}已创建 hosts 文件备份: $HOSTS_BACKUP${NC}"

# 下载最新的 GitHub hosts
TEMP_HOSTS=$(mktemp)
if ! curl -s "https://gitlab.com/ineo6/hosts/-/raw/master/next-hosts" > "$TEMP_HOSTS"; then
    echo -e "${RED}下载 GitHub hosts 失败${NC}"
    rm -f "$TEMP_HOSTS"
    exit 1
fi

# 删除已存在的 GitHub hosts 配置
if grep -q "$START_MARK" "$HOSTS_FILE"; then
    sed -i "/$START_MARK/,/$END_MARK/d" "$HOSTS_FILE"
fi

# 添加新的 GitHub hosts 配置
{
    echo "$START_MARK"
    cat "$TEMP_HOSTS"
    echo "$END_MARK"
} >> "$HOSTS_FILE"

# 清理临时文件
rm -f "$TEMP_HOSTS"

# 刷新 DNS 缓存
if command -v systemd-resolve >/dev/null 2>&1; then
    systemd-resolve --flush-caches
elif command -v systemctl >/dev/null 2>&1; then
    systemctl restart systemd-resolved
fi

echo -e "${GREEN}GitHub hosts 更新成功！${NC}"
echo -e "${YELLOW}提示: 使用 --remove 参数运行此脚本可以删除 GitHub hosts 配置${NC}" 