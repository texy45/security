#!/bin/bash

if  (( $# != 1 ))
then
	printf "[-] %s <url>\n" $0
	exit
fi

url=$1

curl -s --insecure $url/robots.txt|grep -i disallow

