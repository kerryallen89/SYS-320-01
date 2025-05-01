#!/bin/bash

> "report.txt"

while read -r pattern; do
	grep "$pattern" "access.log" | awk '{print $1, $4, $5, $7}' | sed 's/\[//g; s/\]//g' >> "report.txt"
done < "IOC.txt"

echo "The report was generated for: report.txt"
