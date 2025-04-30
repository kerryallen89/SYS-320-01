clear

. "c:\Users\champuser\SYS-320-01\week6\Event-Logs.ps1"
. "c:\Users\champuser\SYS-320-01\week7\Email.ps1"
. "c:\Users\champuser\SYS-320-01\week7\Scheduler.ps1"
. "c:\Users\champuser\SYS-320-01\week7\Configurations.ps1"

# Obtaining Configuration
$configuration = readConfiguration

# Obtaining at risk users
$Failed = atRiskUsers 

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($config[1])
