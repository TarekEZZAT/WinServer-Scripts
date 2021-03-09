# DNS Zones Management

Clear-DnsServerCache
Clear-DnsClientCache

Add-DnsServerForwarder 8.8.8.8
Add-DnsServerConditionalForwarder yahoo.com 8.8.4.4

Remove-DnsServerForwarder 8.8.8.8
Remove-DnsServerForwarder 8.8.4.4
Remove-DnsServerForwarder 4.4.8.8
Remove-DnsServerZone -Name "yahoo.com"



Show-DnsServerCache
Get-DnsClientCache

Remove-DnsServerRootHint server1.opendns.com
Clear-DnsServerCache
Clear-DnsClientCache
ipconfig /flushdns


Show-DnsServerCache
Get-DnsClientCache





