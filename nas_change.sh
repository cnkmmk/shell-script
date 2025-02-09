#!/bin/bash

# 定义配置文件路径
SINGBOX_CONFIG="/etc/sing-box/config.json"
HYSTERIA_CONFIG="/etc/hysteria/config.yaml"

# 获取新端口号
NEW_PORT=$(ssh -p 22551 root@nat.fw.cnkmmk.win "bash <(curl -sSLf https://raw.githubusercontent.com/cnkmmk/shell-script/main/changeport.sh)")

# 检查是否成功获取新端口号
if [[ -z "$NEW_PORT" ]]; then
  echo "错误：未能获取到新端口号。"
  exit 1
fi

# 更新 Sing-box 配置文件
sed -i.bak "s/\"server\": \"nat.fw.cnkmmk.win\",\"server_port\": [0-9]\+,/\"server\": \"nat.fw.cnkmmk.win\",\"server_port\": ${NEW_PORT},/" "$SINGBOX_CONFIG"

# 检查 Sing-box 更新是否成功
if [[ $? -ne 0 ]]; then
  echo "错误：更新 Sing-box 配置文件失败。"
  exit 1
fi

# 更新 Hysteria 配置文件
sed -i.bak "s/server: nat.fw.cnkmmk.win:[0-9]\+/server: nat.fw.cnkmmk.win:${NEW_PORT}/" "$HYSTERIA_CONFIG"

# 检查 Hysteria 更新是否成功
if [[ $? -ne 0 ]]; then
  echo "错误：更新 Hysteria 配置文件失败。"
  exit 1
fi

# 重启相关服务
#/usr/bin/systemctl restart hysteria-server
/usr/bin/systemctl restart sing-box

# 输出结果
echo "成功更新端口号为：${NEW_PORT}"
