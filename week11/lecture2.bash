#!/bin/bash

pageCount=""
file="/var/log/apache2/access.log"

function getPageCount(){
pageCount=$(cat "$file" | cut -d' ' -f7 | tr -d "[" | sort | uniq -c)
}

#function ips(){
#ipsAccessed=$(echo "$pageCount" | cut -d' ' -f1)
#}

getPageCount
echo "$pageCount"
