

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

#checkUser function - Finished

 function checkUser($name){
    $check = Get-LocalUser -Name $name -ErrorAction SilentlyContinue
    
    if ($name -eq $check){
        Write-Host "This user already exists :("

    }
    else{
        $checkUser = $true
    }
    return $checkUser
}

#checkUser exists

 function checkUserExist($name){
    $check = Get-LocalUser -Name $name -ErrorAction SilentlyContinue
    
    if ($name -eq $check){
        $checkUser = $true

    }
    else{
        Write-Host "User wasn't found :("
    }
    return $checkUser
}

#Checking Password - finished

function checkPassword($password){
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $dehashPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    #this checks for special characters within password

    if ($dehashPassword -match '[^a-zA-z0-9\s]'){
        $checkPass = $true

    }
    else{
        Write-Host "Passwords requires at least one special character to proceed"
        return $checkPass = $false
    }

    #this checks for password length

    if ($dehashPassword.length -ge 8){
        $checkPass = $true

    }
    else{
        Write-Host "Password requires at least 8 characters to be valid"
        truth $checkPass = $false
    }

    #this checks for numbers

    if ($dehashPassword -match '[0-9]'){
        $checkPass = $true
    }
    else{
        Write-Host "Password requires a number"
        return $checkPass = $false
    }
    
    #this checs for letters
    
    if ($dehashPassword -match '[a-zA-Z]'){
        $checkPass = $true
    }
    else{
        Write-Host "Password requires a number"
        return $checkPass = $false
    }
    return $checkPass
}