#!/bin/bash

# System Health Report Generator

echo "=========================================="
echo "🖥️  System Health Report - $(date)"
echo "=========================================="

# Uptime
echo ""
echo "🔁 Uptime:"
uptime -p

# Memory Usage
echo ""
echo "🧠 Memory Usage:"
free -h

# Disk Usage
echo ""
echo "💾 Disk Usage:"
df -h /

# CPU Load
echo ""
echo "🔥 CPU Load:"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

# Top 5 processes by memory
echo ""
echo "📊 Top 5 Memory-Consuming Processes:"
ps aux --sort=-%mem | head -n 6

