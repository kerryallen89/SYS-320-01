clear

.(Join-Path $PSScriptRoot Apache-Logs.ps1)
.(Join-Path $PSScriptRoot ParsingApacheLogs.ps1)

#Used to test WindowsApacheLogs
apache-logs SummerCivilian 404 chrome

#Used to test ParsingApacheLogs
$test = apacheLogFilter
$test | Format-Table -AutoSize -Wrap