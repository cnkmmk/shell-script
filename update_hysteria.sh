#!/bin/bash
systemctl stop hysteria-server
arch=`dpkg --print-architecture`
hysver=`curl -Ls "https://api.github.com/repos/apernet/hysteria/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'`
curl -L -o /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/download/${hysver}/hysteria-linux-${arch}
chmod +x /usr/local/bin/hysteria
systemctl start hysteria-server
sleep 5
systemctl status hysteria-server
