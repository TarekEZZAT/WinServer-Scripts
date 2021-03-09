#Set ServerIPConfigutration

$NewIpv4Address ="192.168.10.2"
$NewIpv4Address
Get-NetIPConfiguration

$OldIPv4Address = (Get-NetIPConfiguration).IPv4Address.IPAddress
$OldIPv4Address
 
$ifAlias = (Get-NetIPConfiguration).InterfaceAlias
$ifAlias
# $ifIndex = Get-NetIPConfiguration |  Select InterfaceIndex
$ifIndex = (Get-NetIPConfiguration).InterfaceIndex
$IfIndex 


Remove-NetIPAddress $OldIPv4Address -InterfaceIndex $IfIndex 
Get-NetIPConfiguration
New-NetIPAddress $NewIpv4Address -InterfaceIndex $IfIndex
Get-NetIPConfiguration



Get-DnsClientServerAddress -InterfaceAlias $ifAlias
set-DnsClientServerAddress -InterfaceAlias $ifAlias -ServerAddresses "127.0.0.1"
Get-DnsClientServerAddress -InterfaceAlias $ifAlias
Get-NetIPConfiguration

rename-computer WSRV1-DC -Restart
