#!bin/bash -f

file="/var/log/apache2/access.log"

results=$(awk '{print $1. $7}' "$file" | grep "page2.html"| tr -d "/")

echo "$results"
