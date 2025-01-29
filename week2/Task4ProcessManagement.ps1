#Task 4:
$chrome = Get-Process | Where-Object {$_.ProcessName -eq "chrome" }
if ($chrome) {
    Stop-Process -Name "chrome" -Force
} else {
Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
}
