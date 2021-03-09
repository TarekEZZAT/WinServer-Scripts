# Set-ServerDNSFeature

$ifAlias = (Get-NetIPConfiguration).InterfaceAlias
$ifAlias

Get-DnsClientServerAddress -InterfaceAlias $ifAlias
Get-NetIPConfiguration

set-DnsClientServerAddress -InterfaceAlias $ifAlias -ServerAddresses "127.0.0.1"
#set-DnsClientServerAddress -InterfaceAlias $ifAlias -ServerAddresses ("127.0.0.1","8.8.8.8")
Get-NetIPConfiguration


Get-WindowsFeature

Add-WindowsFeature DNS -IncludeManagementTools

Show-DnsServerCache
Clear-DnsServerCache
Show-DnsServerCache

Get-DnsClientCache
Clear-DnsClientCache

Get-DnsClientCache
ping www.google.fr


Add-DnsServerForwarder 8.8.8.8
Remove-DnsServerForwarder 8.8.8.8
Add-DnsServerConditionalForwarderZone yahoo.com 8.8.4.4
Remove-DnsServerZone yahoo.com 

Get-DnsClientServerAddress -InterfaceAlias $ifAlias
Get-NetIPConfiguration
