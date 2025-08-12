#!/bin/bash

# Ensure logs directory exists
mkdir -p "$(dirname "$0")/../logs"

# Create timestamped log file
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
log_file="$(dirname "$0")/../logs/system_health_${timestamp}.log"

# Warn if not run with sudo
if [[ $EUID -ne 0 ]]; then
  echo "⚠️  Please run this script with sudo/root privileges for complete data (especially network connections)."
fi

# Begin report
{
echo "=============================================="
echo "📊 SYSTEM HEALTH REPORT - $(date)"
echo "=============================================="

echo -e "\n🕒 UPTIME:"
uptime -p

echo -e "\n💻 OS INFORMATION:"
[ -f /etc/os-release ] && grep -E 'PRETTY_NAME|VERSION=' /etc/os-release

echo -e "\n🧠 CPU LOAD:"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

echo -e "\n📦 MEMORY USAGE:"
free -h

echo -e "\n💽 DISK USAGE:"
df -hT | grep -v tmpfs

echo -e "\n🔥 TOP 5 CPU-CONSUMING PROCESSES:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

echo -e "\n💾 TOP 5 MEMORY-CONSUMING PROCESSES:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

echo -e "\n🌐 NETWORK INTERFACES:"
ip -brief address || ifconfig

echo -e "\n🔗 ACTIVE NETWORK CONNECTIONS (Top 10):"
ss -tunap | head -n 10 || netstat -tunap | head -n 10

echo -e "\n✅ REPORT COMPLETED!"
echo "📁 Log file saved to: $log_file"
} | tee "$log_file"
