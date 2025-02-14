clear 
function Get-LoginEvents {
    param(
        [int]$DaysAgo
    )

$loginouts = Get-EventLog system -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-$DaysAgo)
$loginoutsTable = @()

for($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}

#Translate the SID to a username
$sid = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1]) 
$user = $sid.Translate([System.Security.Principal.NTAccount]).Value
    
$loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                       "Id" = $loginouts[$i].InstanceId;
                                    "Event" = $event;
                                     "User" = $user;
                                    }
    }

    return $loginoutsTable
}

function Get-SystemEvents {
    param(
        [int]$DaysAgo
    )
    
    $systemEvents = Get-EventLog system -After (Get-Date).AddDays(-$DaysAgo) |
                    Where-Object {$_.EventId -eq 6005 -or $_.EventId -eq 6006}
    
    $systemEventsTable = @()
    
    for ($i = 0; $i -lt $systemEvents.Count; $i++) {

    $event = ""
    if ($systemEvents[$i].EventId -eq 6005) {$event = "Startup"}
    if ($systemEvents[$i].EventId -eq 6006) {$event = "Shutdown"}
    
    $systemEventsTable += [PSCustomObject]@{"Time" = $systemEvents[$i].TimeGenerated;
                                              "Id" = $systemEvents[$i].EventID;
                                           "Event" = $event
                                            "User" = "System"
                                           }
    }

    return $systemEventsTable
}


# Calls both funtions and prints the results
$DaysToRetrieve = 14


$loginResults = Get-LoginEvents -DaysAgo $DaysToRetrieve
Write-Output "Logon/Logoff Events:"
$loginResults

$systemResults = Get-SystemEvents -DaysAgo $DaysToRetrieve
Write-Output "`nSystem Startup/Shutdown Events:"
$systemResults
