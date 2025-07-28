#!/bin/bash

# ════ SYSTEM HEALTH REPORT ════

# Create logs directory if it doesn't exist
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

# Generate timestamped log file
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE="$LOG_DIR/system_health_$TIMESTAMP.log"

# Redirect output to both terminal and log file
{
echo "-----------------------------------"
echo "📊 System Health Report - $(date)"
echo "-----------------------------------"

echo -e "\n🕒 Uptime:"
uptime -p

echo -e "\n💻 OS Info:"
[ -f /etc/os-release ] && grep -E 'PRETTY_NAME|VERSION=' /etc/os-release

echo -e "\n🧠 CPU Load:"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

echo -e "\n📦 Memory Usage:"
free -h

echo -e "\n💽 Disk Usage:"
df -hT | grep -v tmpfs

echo -e "\n🔥 Top 5 CPU-consuming processes:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

echo -e "\n💾 Top 5 Memory-consuming processes:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

echo -e "\n🌐 Network Interfaces:"
ip -brief address || ifconfig

echo -e "\n🔗 Active Network Connections:"
ss -tunap | head -n 10 || netstat -tunap | head -n 10

echo -e "\n✅ Report Completed!"
} | tee "$LOG_FILE"
