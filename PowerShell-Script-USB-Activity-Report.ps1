<# 
 NOTES
  Version:        1.0
  Author:         CountDClem
  Creation Date:  2021-06-28
  Purpose/Change: N/A Initial script development

  Locally ran script 

  Outputs: USB InstallDate, FirstInstallDate, LastArrivalDate, & LastRemovalDate

  to Desktop\USB-Activity-Report-Date_yyyy-MM-dd-Time_hhmm.csv

This posting is provided "AS IS" with no warranties, and confers no rights.
This Sample Code is provided for the purpose of illustration only and is not
intended to be used in a production environment.  THIS SAMPLE CODE AND ANY
RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.  We grant You a
nonexclusive, royalty-free right to use and modify the Sample Code and to
reproduce and distribute the object code form of the Sample Code, provided
that You agree: (i) to not use Our name, logo, or trademarks to market Your
software product in which the Sample Code is embedded; (ii) to include a valid
copyright notice on Your software product in which the Sample Code is embedded;
and (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and
against any claims or lawsuits, including attorneys’ fees, that arise or result
from the use or distribution of the Sample Code.
#>




$i = 0 
#Sets the file date by Year, Month, Day, Hour and Minute 
$reportdate = get-date -Format "'Date'_yyyy-MM-dd-'Time'_hhmm"

#Pulls all system devices and sorts output with USB and date 
$USBs = (Get-PnpDevice).InstanceId
foreach ($USB in $USBs) {
$i++
   Write-Progress -activity "Reviewing  $USB . . ." -status "Analyzed: $i of $($USBs.Count)" -percentComplete (($i / $USBs.Count)  * 100)
   write-host "Conducting analysis of $USB" -ForegroundColor DarkYellow
Get-PnpDeviceProperty -InstanceId $USB | 
where {$_.KeyName -like "*date*" -and $_.DeviceID -like "USB*"} | 
select DeviceID, KeyName, Data | 
Export-csv $home\Desktop\USB-Activity-Report-$reportdate.csv -NoTypeInformation -Append
}