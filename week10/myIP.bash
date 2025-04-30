#!bin/bash

ip addr show | grep  "inet " | awk '{print $2}' | cut -d'/' -f1 | grep -vE '127' 
