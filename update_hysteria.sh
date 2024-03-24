#!/bin/bash
systemctl stop hysteria
arch=`dpkg --print-architecture`
hysver=`curl -Ls "https://api.github.com/repos/apernet/hysteria/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'`
wget -O /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/download/${hysver}/hysteria-linux-${arch}
chmod +x /usr/local/bin/hysteria
systemctl start hysteria
