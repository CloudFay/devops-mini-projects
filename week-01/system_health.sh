#!/bin/bash

# ════ SYSTEM HEALTH REPORT ════
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

