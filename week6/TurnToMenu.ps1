.(Join-Path $PSScriptRoot ParsingApacheLogs.ps1)
.(Join-Path $PSScriptRoot Event-Logs.ps1)
.(Join-Path $PSScriptRoot Task4ProcessManagment.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display the last 10 apache logs`n"
$Prompt += "2 - Display the last 10 failed logins`n"
$Prompt += "3 - Display users who are risk`n"
$Prompt += "4 - Open / Close Google Chrome`n"
$Prompt += "5 - Exit`n"

$run = $true

while ($run){
    Write-Host $Prompt | Out-String
    $choices = Read-Host

    if($choices -eq 5){
        $run = $false
        exit
    }
    elseif($choices -eq 1){
        cd C:\Users\champuser\SYS-320-01\week4
        $test = .\WindowsApacheLogs.ps1
        $test | Select-Object -Last 10
    }
    elseif($choices -eq 2){
        $test = getFailedLogins 90
        $test | Select-Object -Last 10
    }
    elseif($choice -eq 3){
        atRiskUser 90
    }
    elseif($choice -eq 4){
        cd C:\Users\champuser\SYS-320-01\week2
        .\Task4ProcessManagment.ps1
    }
    else{
        Write-Host "Invalid Option, Type another option in :)"
    }
}