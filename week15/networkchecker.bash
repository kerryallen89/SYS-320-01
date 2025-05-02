#!/bin/bash

myIP=$(bash myIP.bash)


# Todo-1: Create a helpmenu function that prints help for the script
function helpmenu(){
	echo "HELP MENU"
	echo "------------------"
	echo "-n: Add -n as an argument for this script to use nmap"
	echo "-n external: External NMAP scan"
	echo "-n internal: Internal NMAP scan"
	echo "-s: Add -s as an argumnt for this script to use ss"
	echo "-s external: External ss(Netstat) scan"
	echo "-s internal: Internal ss(Netstat) scan"
	echo ""
	echo "Usage: bash networkchecker.bash -n/-s external/internal"
	echo "---------------"
}

# Return ports that are serving to the network
function ExternalNmap(){
	rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
	echo "$rex"
}

# Return ports that are serving to localhost
function InternalNmap(){
	rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
	echo "$rin"
}


# Only IPv4 ports listening from network
# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
 function ExternalListeningPorts(){
	elpo=$(ss -ltpn | grep -v "127.0.0." | grep "LISTEN" |  awk '{print $4,$7}' | sed 's/.*://' | sed 's/users:((//' | sed 's/".*//') 
	echo "$elpo"
 }


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
	ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
	echo "$ilpo"
}


# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu
if [ $# -eq 0 ]; then
	helpmenu
fi

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)

optfound=0
while getopts ":n:s:" option; do
	optfound=1
	case $option in
		n)
			if [ "$OPTARG" = "internal" ]; then
				InternalNmap
			elif [ "$OPTARG" = "external" ]; then
				ExternalNmap
			else
				echo "It needs to be internal or external :("
				helpmenu
			fi
			;;
		s)
			if [ "$OPTARG" = "internal" ]; then
				InternalListeningPorts
			elif [ "$OPTARG" = "external" ]; then
				ExternalListeningPorts
			else
				echo "It needs to be internal or external :("
				helpmenu
			fi
			;;
		*)
			echo "ILLEGAL OPTION!!! NEEDS TO BE -n or -s!!"
			helpmenu
			;;
	esac
done

# If no valid options are provided, this happens.
if [ $optfound -eq 0 ]; then
	helpmenu
fi

