
Get-NetIPConfiguration 
Get-NetIPConfiguration | Select-Object InterfaceAlias , InerfaceIndex
Get-NetIPConfiguration | Select-Object InterfaceAlias 
$ifAlias = Get-NetIPConfiguration | Select-Object InterfaceAlias
$ifAlias

set-DnsClientServerAddress -InterfaceAlias $ifAlias -ServerAddresses ("192.168.10.2","192.168.10.5")

rename-computer W10DT1-CL
Add-Computer -DomainName labs.local -Confirm -Force -Restart