#Task 1: List every process where ProcessName starts with 'C':
Get-Process | Where-Object { $_.ProcessName -match "^C" }

#Task 2:
Get-WmiObject Win32_Process | Where-Object {$_.ExecutablePath -notmatch "system32" }
Select-Object ProcessId, Name, ExecutablePath

#Task 3:
Get-Service | Where-Object {$_.Status -eq "Stopped" } |
Sort-Object DisplayName |
Export-Csv -Path "StoppedServices.csv" -NoTypeInformation

#Task 4:
$chrome = Get-Process | Where-Object {$_.ProcessName -eq "chrome" }
if ($chrome) {
    Stop-Process -Name "chrome" -Force
} else {
Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
}
