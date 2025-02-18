clear

function apache-logs ($page, $httpCode, $webBrowser){
    cd C:\xampp\apache\logs
    $logSearch = Get-Content C:\xampp\apache\logs\access.log | Select-String $page | Select-String $httpCode
    $notfound = $logSearch | Select-String $webBrowser

    #Define a regex for IP addresses
    $regex = [regex] "\b\d{1,5}\.\d{1,5}\.\d{1,5}\.\d{1,5}\b"

    #Get $notfounds records that match to the regex
    $ipsUnorganized = $regex.Match($notfound)

    #Get ips as pscustomobject
    $ips = @()
    for($i=0; $i -lt $ipsUnorganized.Count; $i++){
        $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].value;}
    }
    $ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
    $counts = $ipsoftens | Group
    $counts | Select-Object Count, Name
}