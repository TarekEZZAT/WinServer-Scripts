#$NewIpv4Addresses = ("192.168.10.101","192.168.10.102","192.168.10.103")
$NewIpv4Addresses = "192.168.10.101"
$NewIpv4Addresses

$DefaultGateway ="192.168.10.254"
$DefaultGateway

$PrefixLength = 24
$PrefixLength



Get-NetIPConfiguration
$OldIPv4Addresses = (Get-NetIPConfiguration).IPv4Address.IPAddress
$OldIPv4Addresses
 
$ifAlias = (Get-NetIPConfiguration).InterfaceAlias
$ifAlias
# $ifIndex = Get-NetIPConfiguration |  Select InterfaceIndex
$ifIndex = (Get-NetIPConfiguration).InterfaceIndex
$IfIndex 

 
<#
Remove-NetIPAddress 192.168.10.101 -InterfaceIndex $IfIndex
Remove-NetIPAddress 192.168.10.102 -InterfaceIndex $IfIndex
Remove-NetIPAddress 192.168.10.103 -InterfaceIndex $IfIndex
#>

forEach ($address in $OldIPv4Addresses){
Remove-NetIPAddress $address -InterfaceIndex $IfIndex 
}



 
# 
# New-NetIPAddress 192.168.10.101 -InterfaceAlias $ifAlias
# New-NetIPAddress 192.168.10.102 -InterfaceAlias $ifAlias
# New-NetIPAddress 192.168.10.103 -InterfaceAlias $ifAlias
# 

forEach ($address in $NewIPv4Addresses){
New-NetIPAddress $address -InterfaceIndex $IfIndex -DefaultGateway $DefaultGateway -PrefixLength 24
}

set-DnsClientServerAddress -InterfaceAlias $ifAlias -ServerAddresses ("192.168.10.2","192.168.10.5")
Get-NetIPConfiguration

rename-computer W10DT1-CL
Add-Computer -DomainName $DomainName -Credential $DomainCredential  -Force -Restart

#Add-Computer -Credential $DomainCredential -DomainName $DomainName -Force -LocalCredential $LocalCredential -Restart

#Add-Computer -DomainName mydomain -Credential mydomain\Administrator -Restart

#add-computer -computername (get-content servers.txt) -domainname ad.contoso.com –credential AD\adminuser -restart –force

add-computer -computername (get-content servers.txt) -domainname ad.contoso.com –credential AD\adminuser -restart –force







