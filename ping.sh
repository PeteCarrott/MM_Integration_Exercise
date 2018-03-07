#!/bin/bash

function pingServer {
	while [ $loop == true ]; do
		echo "what is the server ip address you want to ping?"
		read ipAddress
		ping -c 1 $ipAddress
		if [ $? == 0 ]; then
			echo "server reachable"
		else
			echo "server not reachable"
		fi
		echo "Do you want to ping another server? Y/N"
			read response
			neg="N"
			if [ $response == $neg ]; then
				loop=false
				echo "Application terminated"
			fi
	done
}

echo "application started"
echo "try to ping the server connected via usb"
loop=true
pingServer
	
