clear

$ConfigPath = "C:\Users\champuser\SYS-320-01\week7\configuration.txt"

function readConfiguration {
    if (Test-Path $ConfigPath) {
        $config = Get-Content $ConfigPath
        [pscustomobject]@{
            "Days"           = $config[0]
            "Execution Time" = $config[1]
        }
    } else {
        Write-Host "Configuration file not found."
    }
}

function changeConfiguration {
    $days = Read-Host "Enter number of days (digits only)"
    $time = Read-Host "Enter execution time (e.g., 12:34 AM)"

    if ($days -match '^\d+$' -and $time -match '^(0?[1-9]|1[0-2]):[0-5][0-9] (AM|PM)$') {
        @($days, $time) | Out-File -FilePath $ConfigPath
        Write-Host "Configuration updated."
    } else {
        Write-Host "Invalid input. Please try again."
    }
}

function configurationMenu {
    Write-Host "`n1: Show configuration"
    Write-Host "2: Change configuration"
    Write-Host "3: Exit"
}

while ($true) {
    configurationMenu
    $choice = Read-Host "Choose an option (1, 2, or 3)"

    if ($choice -eq "1") {
        $config = readConfiguration
        if ($config) {
            $config | Format-Table
        }
    } elseif ($choice -eq "2") {
        changeConfiguration
    } elseif ($choice -eq "3") {
        Write-Host "Goodbye!"
        break
    } else {
        Write-Host "Invalid choice. Enter 1, 2, or 3."
    }
}
