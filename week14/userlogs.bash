#!/bin/bash

authfile="/var/log/auth.log"
accesslog="/home/champuser/SYS-320-01/week14/fileaccesslog.txt"

function getSuccessfulLogins(){
	logLine=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logLine" | cut -d' ' -f1,2,12 | tr -d '\.')
	echo "[Successful Logins]" >> "$accesslog"
	echo "$dateAndUser" >> "$accesslog"
	echo "" >> "$accesslog"
}

function getFailedLogins
	logLine=$(cat "$authfile" | grep "Failed Password :(")
	dateAndUser=$(echo "$logLine" | cut -d' ' -f1,2,17)
	echo "[Failed Logins]" >> "$accesslog"
	echo "$dateAndUser" >> "$accesslog"
	echo "" >> "$accesslog"
}


getSuccessfulLogins
getFailedLogins
