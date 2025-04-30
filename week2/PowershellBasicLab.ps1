#Get the IPv4 Address from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object{ $_.InterfaceAlias -ilike "Ethernet0"}).IPAddress

#Get IPv4 PrefixLength from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object{ $_.InterfaceAlias -ilike "Ethernet0"}).PrefixLength

#Show what classes there is of win32 library that starts with Net, then sort alphabetically
Get-WmiObject -list | Where-Object { $_.name -ilike "win32_net*" } | Sort-Object

#Get dhcp server IP, and then hide the table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

#Get DNS server ips and display only the first one
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object{ $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses
# -----------------------------------------------------------

#Choose a directory where you have some .ps1 files
cd $PSScriptRoot

# List files based on the file name
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Exists; $j++){

    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

# Create folder if it does not exist
$folderpath="$PSScriptRoot\outfolder"
if (Get-ChildItem $folderpath){
    Write-Host 'Folder Already Exists'
}
else{
    New-Item -Name "outfolder" -ItemType "directory" -Path $folderpath
}

cd $PSScriptRoot
$files=Get-ChildItem

#$folderpath = "$PSScriptRoot/outfolder/"
#$filePath = Write-Host $folderpath "out.csv"

$files | Where-Object {$_.Extension -eq ".ps1" } | Export-Csv -Path $PSScriptRoot\outfolder\out.csv

#Without changing directory (don't go in outfolder), find
#every .csv file recursively and change their extensions to .log
#Recursively display all the files (not directories)

$files = Get-ChildItem -Path . -Filter "*.csv" -File -Recurse
$files | Rename-Item -NewName { $_.Name -replace '\.csv', '.log' }
Get-ChildItem -Path . -File -Recurse