#!/bin/bash

for ((j=1;j<16;j++)); do
	
	echo "$(sudo tcpdump -i any host $@ -nne -vvv -c 10 -s 1500 -w /tmp/tcp_$(date  "+%Y%m%d-%H%M%S").pcap)"


done

























