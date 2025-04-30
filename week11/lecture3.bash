#!/bin/bash

file="/var/log/apache2/access.log.1"

cat $file | grep "curl" | cut -d' ' -f1,12 | uniq -c
