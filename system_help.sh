#!/bin/bash

SCRIPT_VERSION="0.1"
# things to check
# internal ip, external ip, dns server, connectivity to google
# filesystem usage, current system load, memory usage

> log.log
date >> log.log
IP=`ip addr | grep -P -o '\d{1,3}.\d{1,3}\.\d{1,3}\.\d{1,3}\/24'`
EXT_IP=`curl -s www.ipchicken.com | grep -o -P '\d{1,3}.\d{1,3}\.\d{1,3}\.\d{1,3}'`
DNS_1=`grep -P -o '\d{1,3}.\d{1,3}\.\d{1,3}\.\d{1,3}' /etc/resolv.conf`

echo "Internal IP:" $IP >> log.log
echo "External IP:" $EXT_IP >> log.log
echo "DNS Server 1:" $DNS_1 >> log.log

MEM_USAGE=`free -m`
echo -e "\nMemory Information\n" >> log.log
echo -e "$MEM_USAGE" >> log.log 

DISK_USAGE=`df -h`
echo -e "\nDisk Usage\n" >> log.log
echo -e "$DISK_USAGE" >> log.log

TOP_SNAPSHOT=`top -n 1 -b`
echo -e "\nTop Processes\n" >> log.log
echo -e "$TOP_SNAPSHOT" >> log.log

UPTIME_SNAPSHOT=`uptime`
echo -e "\nUptime\n" >> log.log
echo -e "$UPTIME_SNAPSHOT" >> log.log

# now lets try some active tests
echo -e "\nPing Test\n" >> log.log
if eval "ping -q -c 1 google.com> /dev/null"
then
	echo -e "Ping Test: Successful!" >> log.log	
else
	echo -e "Ping Test: Failed!" >> log.log	
fi
