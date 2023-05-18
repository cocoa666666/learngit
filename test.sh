#!/bin/sh

interface="utun3"  # 替换为你使用的虚拟网卡名称

# 获取发送的字节数
sent_bytes=$(netstat -ibn | awk '/'"$interface"'/ {print $7}')

# 获取接收的字节数
received_bytes=$(netstat -ibn | awk '/'"$interface"'/ {print $10}')

echo "Interface: $interface"
echo "Bytes Sent: $sent_bytes"
echo "Bytes Received: $received_bytes"





