.(Join-Path $PSScriptRoot FunctionEventLogs.ps1)

clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = Get-LoginEvents -DaysAgo 15
$loginoutsTable

# Get shutdown from the last 25 days
$shutdownsTable = Get-SystemEvents -DaysAgo 25 Where-Object {$_.Event -eq "Shutdown"}
$shutdownsTable

# Get Startup from the last 25 days
$startupsTable = Get-SystemEvents -DaysAgo 25 Where-Object {$_.Event -eq "Startup"}
$startupsTableD