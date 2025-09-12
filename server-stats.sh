#!/bin/bash

## Memory 
memtot=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
memfree=$(cat /proc/meminfo | grep MemFree | awk '{print $2}')
memavil=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
memused=$((memtot - memavail))

## Uptime
ut=$(uptime | awk '{print $1}')

## Disk
dsktotal=$(df -h --total | grep total | awk '{print $2}')
dskfree=$(df -h --total | grep total | awk '{print $4}')
dskused=$(df -h --total | grep total | awk '{print $3}')
dskperc=$(df -h --total | grep total | awk '{print $5}')

## Cpu Usage
cpusg=$(top -n 1 -b | grep %Cpu | awk 'BEGIN{getline; printf "%.1f", 100 - $8}')

## Top 5 Process by CPU
top5cpu=$(top -n 1 -b -o -%CPU |awk '{a[NR%5] = $12} END {for (i=NR+1; i<=NR+5; i++) print a[i%5]}')

## Top 5 Process by MEM
top5mem=$(top -n 1 -b -o -%MEM |awk '{a[NR%5] = $12} END {for (i=NR+1; i<=NR+5; i++) print a[i%5]}')

echo "Server Stats"
echo ""
echo "# 1. Uptime"
echo "Total Uptime is "$ut
echo "# 2. CPU"
echo " Used CPU = "$cpusg"%"
echo "Top 5 Process by CPU =("$top5cpu")"
echo "# 3. Memory"
echo "Total Memory = "$memtot
echo "Free Memory = "$memfree
echo "Used Memory = "$memused
echo "Top 5 Process by MEM =("$top5mem")"
echo "# 4. Disk"
echo "Total Disk = "$dsktotal
echo "Free Disk = "$dskfree
echo "Used Disk = "$dskused
echo "Used Disk % = "$dskperc
