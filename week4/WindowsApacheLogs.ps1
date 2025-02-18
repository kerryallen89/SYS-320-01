clear

cd C:\xampp\apache\logs

# List all of the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log

#List only last 5 Apache logs
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Display only logs that contain 404 (Not Found) or 400 (Bad Request)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

#Display only logs that does NOT contain 200 (OK)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#From every .log file in the directory, only get logs that contains the word 'error'
#$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'
#Display last 5 elements of the result array
#$A[-5..-1]

#Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

#Define a regex for IP addresses
$regex = [regex] "\b\d{1,5}\.\d{1,5}\.\d{1,5}\.\d{1,5}\b"

#Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Match($notfounds)

#Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].value;}
}
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$count = $ipsoftens | Group
$count | Select-Object Count, Name
