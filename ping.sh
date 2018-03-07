#!/bin/bash
echo "application started"
echo "try to ping the server connected via usb"
ping -c 139.128.8.243
if [ $? == 0 ]; then
	echo "server reachable"
else
	echo "server not reachable"
fi
	
