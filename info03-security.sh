#!/bin/bash

if  (( $# != 1 ))
then
	printf "[-] %s <url à tester>\n" $0
	exit
fi

url=${1}

wget --no-verbose ${url}/security.txt && cat security.txt && rm security.txt
wget --no-verbose ${url}/.well-known/security.txt && cat security.txt && rm security.txt
