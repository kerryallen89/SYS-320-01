#!/bin/bash

echo "The file was accessed on: $(date '+%a %b %d %I-%M-%S %p %Z %Y')" >> /home/champuser/SYS-320-01/week14/fileaccesslog.txt

cat /home/champuser/SYS-320-01/week14/fileaccesslog.txt | tr ':' '-' | ssmtp kerry.allen@mymail.champlain.edu
