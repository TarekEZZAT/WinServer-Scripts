# Set-ServerDNSFeature

$ifAlias = (Get-NetIPConfiguration).InterfaceAlias
$ifAlias

Get-DnsClientServerAddress -InterfaceAlias $ifAlias
Get-NetIPConfiguration


Get-WindowsFeature

Add-WindowsFeature DNS -IncludeManagementTools

Show-DnsServerCache
Clear-DnsClientCache

get-dnsclientcache
ping www.google.fr


Add-DnsServerForwarder 8.8.8.8
Remove-DnsServerForwarder 8.8.8.8
Add-DnsServerConditionalForwarderZone yahoo.com 8.8.4.4
Remove-DnsServerConditionalForwarderZone yahoo.com

Get-DnsClientServerAddress -InterfaceAlias $ifAlias
Get-NetIPConfiguration
