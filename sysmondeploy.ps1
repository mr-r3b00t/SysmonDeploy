$env:PROCESSOR_ARCHITECTURE
$64bit = [Environment]::Is64BitOperatingSystem

if($64bit -eq "True"){

write-host "64Bit OS"

#download swift on security's sysmon config

$url = "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml"
$output = "C:\windows\Temp\sysmonconfig-export.xml"
$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output
#OR
Start-BitsTransfer -Source $url -Destination $output -Asynchronous

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#Download SYSMON
$url = "https://github.com/mr-r3b00t/sysmon/blob/master/Sysmon64.exe?raw=true"
$output = "C:\windows\Temp\sysmon64.exe"
$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output
#OR
Start-BitsTransfer -Source $url -Destination $output -Asynchronous

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"


#remove the mark of the web
Unblock-File "c:\windows\temp\sysmon64.exe"
Unblock-File "c:\windows\temp\sysmonconfig-export.xml"

#install sysmon

$exe = "c:\windows\temp\sysmon64.exe"
&$exe -accepteula -i c:\windows\temp\sysmonconfig-export.xml


}
