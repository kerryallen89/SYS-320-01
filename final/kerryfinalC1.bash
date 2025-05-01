# !/bin/bash

curl -s http://10.0.17.6/IOC.html | \
grep -Eo '(etc/passwd|/bin/bash|/bin/sh|1=1#|1=1--)' > IOC.txt

cat IOC.txt
