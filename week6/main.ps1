. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get Users at Risk`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user - finished
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        $checkUser = $false
        $checkPass = $false

        $checkUser = checkUser $name

        $checkPass = checkpassword $password

        if($checkUser -and $checkPass){
            createAUser $name $password
            Write-Host "User: $name is created." | Out-String
    }
}


    # Remove a user 
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

    # CheckUser Function - finished

        $check = checkUserExist $name
        
        if($check){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "User cannot be found"
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # checkUser Function - finished

        $check = checkUserExist $name

        if($check){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "User cannot be found"
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # checkUser function - Finished

        $check = checkUserExist $name
        
        if($check){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "User cannot be found"
        }
    }

    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # checkUser function - done

        if(checkUserExist $name){
            $userLogins = getLogInAndOffs 90

        # TODO: Change the above line in a way that, the days 90 should be taken from the user - done

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User cannot be found"
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # checkUser function - done

        if(checkUserExist $name){
            $userLogins = getFailedLogins 90

        # TODO: Change the above line in a way that, the days 90 should be taken from the user - done

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User cannot be found"
        }

    }

    elseif($choice -eq 9){

        $days = Read-Host -Prompt "Please enter the number of days to check how far back"

        $failedLogins = getFailedLogins $days

        $atRiskUsers = $failedLogins | Group-Object User | Where-Object {$_.Count -gt 10} | Select-Object Name, Count

        Write-Host "Users that have more than 10 failed logins in the last $days days: " | Out-String

        Write-Host ($atRiskUsers | Format-Table | Out-String)
    }
    

    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    #DONE
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    #DONE
    

}




