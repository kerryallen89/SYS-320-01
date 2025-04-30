clear

function SendAlertEmail($Body){

$From = "kerry.allen@mymail.champlain.edu"
$To = "kerry.allen@mymail.champlain.edu"
$Subject = "kerry.allen@mymail.champlain.edu"

$Password = "buvl nqly zokr lvyn" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}

SendAlertEmail "Body of emall"