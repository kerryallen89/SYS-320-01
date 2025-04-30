clear
function getEventLogs ($time){

    $loginouts = Get-Eventlog system -source Microsoft-Windows-Winlogon -After (Get-Date).Adddays(-$time)

    $loginoutsTable = @()
    for ($i=0; $i -lt $loginouts.count; $i++){
        #Creating Event value
        $event = ""
        if($loginouts[$i].instanceID -eq 7001){
            $event = "logon"
        }
        if($loginouts[$i].instanceID -eq 7002){
            $event = "logoff"
        }
        #Creating User value
        $SID = $loginouts[$i].ReplacementStrings[1]
        $test = New-Object System.Security.Principal.SecurityIdentifier($SID)
        $user = $test.Translate([System.Security.Principal.NTAccount])
        #Setting values in the table
        $loginoutsTable += [pscustomobject]@{ "Time" = $loginouts[$i].TimeGenerated ; "Id" = $loginouts[$i].EventID ;"Event" = $event; "User" = $user;}
    }
    $loginoutsTable
}

function getONOffLogs ($EventID, $time){
    #$OnOffLog = Get-WinEvent -FilterHashtable @{logname = "System"; id = 6005,6006}
    $OnOffLog = Get-EventLog -LogName system -After (Get-Date).Adddays(-$time) | Where-Object {$_.EventID -eq $EventID} 

    $OnOffLogTable = @()
    for ($i=0; $i -lt $OnOffLog.count; $i++){
        #Creating Event value
        $event = ""
        if($OnOffLog[$i].EventID -eq 6005){
            $event = "Start Up"
        }
        if($OnOffLog[$i].EventID -eq 6006){
            $event = "Shut Down"
        }
        #Setting values in the table
        $OnOffLogTable += [pscustomobject]@{ "Time" = $OnOffLog[$i].TimeGenerated ; "Id" = $OnOffLog[$i].EventID ;"Event" = $event; "User" = 'system'}
    }
    $OnOffLogTable
}