clear

function GettingIOC(){

    $response = Invoke-WebRequest -Uri "http://10.0.17.15/IOC.html"
    $data = $response.ParsedHtml.body.getElementsByTagName("tr")

    $table = @()

    for($i=1; $i -lt $data.length;$i++){
        $cells = $data[$i].getElementsByTagName("td")
        
        if($i -ne 0){
            $table += [PSCustomObject]@{"Pattern" = $cells[0].innerText;
                                        "Explanation" = $cells[1].innerText}                    
        }
    }

return $table

}

#GettingIOC

#-------------------------------------------------------------------------

function AccessLogs(){
    $access = Get-Content C:\Users\champuser\SYS-320-01\midterm\access.log
    $accessTable = @()

    $access | ForEach-Object{
        $info = $_ -split " "
        $accessTable += [PSCustomObject]@{"IP" = $info[0];
                                          "Time"  = $info[3].Trim('[');
                                          "Method" = $info[5].Trim('"');
                                          "Page" = $info[6];
                                          "Protocol" = $info[7].Trim('"');
                                          "Response" = $info[8];
                                          "Referrer" = $info[9]
                                          }
        }

        return $accessTable
}

AccessLogs

#-------------------------------------------------------------------------

function filteringLogs($access, $filter){

    $compliledLogs = @()

    for($k = 0; $k -lt $access.length; $k++){
        $checkedLogs = $access[$k].Page

        for($i = 0; $i -lt $filter.Length; $i++){
            $checkedFilter = $filter.Pattern[$i]
            $testing = $checkedLogs | Select-String $checkedFilter

            if($testing){
                $compliledLogs +=[PSCustomObject]@{"IP" = $access.IP[$k];
                                                   "Time"  = $access.Time[$k];
                                                   "Method" = $access.Method[$k];
                                                   "Page" = $access.Page[$k];
                                                   "Protocol" = $access.Protocol[$k];
                                                   "Response" = $access.Response[$k];
                                                   "Referrer" = $access.Referrer[$k]}
                     }
                }
            }
            return $compliledLogs | Sort-Object -Property Page -Unique
}

$access = AccessLogs
$filter = GettingIOC
$final = filteringLogs $access $filter
$final | Format-Table -AutoSize -Wrap

                                                