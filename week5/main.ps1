.(Join-Path $PSScriptRoot ScrapingClasses.ps1)

clear

$gatClass = gatherClasses
$FullTable = daysTranslator $gatClass

#Deliverable 1
$FullTable | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             where {$_.Instructor -ilike "Furkan Paligu"}

#Deliverable 2
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -ccontains "Monday")} | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"

#Deliverable 3
$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or `
                                             ($_."Class Code" -ilike "NET*") -or `
                                             ($_."Class Code" -ilike "SEC*") -or `
                                             ($_."Class Code" -ilike "FOR*") -or `
                                             ($_."Class Code" -ilike "CSI*") -or `
                                             ($_."Class Code" -ilike "DAT*")} `
                             | Sort-Object "Instructor" | Select-Object "Instructor" -Unique

#Deliverable 4
$FullTable | where{$_.Instructor -in $ITSInstructors.Instructor} `
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending

$ITSInstructors
$FullTable

