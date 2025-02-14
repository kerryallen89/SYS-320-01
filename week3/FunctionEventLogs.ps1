$loginouts = Get-EventLog system -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)

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

$loginoutsTable
