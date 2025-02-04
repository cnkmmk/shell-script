#!/bin/bash

# 定义配置文件路径
CONFIG_FILE="/etc/hysteria/config.yaml"

# 检查文件是否存在
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "错误: 配置文件 $CONFIG_FILE 不存在。"
  exit 1
fi

# 提取当前端口号
CURRENT_PORT=$(grep -oP 'listen: :\K\d+' "$CONFIG_FILE")

# 检查是否成功提取端口号
if [[ -z "$CURRENT_PORT" ]]; then
  echo "错误: 未找到 listen 行或端口号。"
  exit 1
fi

# 计算新端口号
NEW_PORT=$((CURRENT_PORT + 1))

# 替换端口号
sed -i.bak "s/listen: :${CURRENT_PORT}/listen: :${NEW_PORT}/" "$CONFIG_FILE"

# 输出结果
echo "已将端口号从 ${CURRENT_PORT} 修改为 ${NEW_PORT}。"

/usr/bin/systemctl restart hysteria-server
sleep 5
/usr/bin/systemctl status hysteria-server
