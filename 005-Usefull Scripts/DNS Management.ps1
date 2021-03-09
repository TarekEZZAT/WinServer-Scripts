# DNS Management

Get-DnsServerResourceRecord -ZoneName labs.local
Get-DnsServerResourceRecord -ZoneName labs.local -ComputerName WSRV1-DC
Get-DnsServerResourceRecord -ZoneName labs.local -ComputerName WSRV1-DC -RRType A
Get-DnsServerResourceRecord -ZoneName labs.local -RRType A


Add-DnsServerResourceRecordA -Name training.com -ZoneName labs.local -IPv4Address 192.168.2.56
Get-DnsServerResourceRecord -ZoneName labs.local -RRType A
Remove-DnsServerResourceRecord -Name training.com -ZoneName labs.local -RRType A
Get-DnsServerResourceRecord -ZoneName labs.local -RRType A


Add-DnsServerPrimaryZone -ComputerName WSRV1-DC -NetworkId "192.168.10.0/24" -ReplicationScope Forest
Get-DnsServerZone -ComputerName WSRV1-DC
#
Add-DnsServerResourceRecordPtr `
    -Name "WSRV1-DC" `
    -PtrDomainName "printer.labs.local" `
    -ZoneName "10.168.192.in-addr.arpa" `
    -computerName WSRV1-DC

Get-DnsServerResourceRecord -ComputerName WSRV1-DC -ZoneName "10.168.192.in-addr.arpa"

#

Add-DnsServerResourceRecordCName -ZoneName labs.local -HostNameAlias "WSRV1-DC.labs.local" -Name "LocalServer"
Get-DnsServerResourceRecord -ZoneName labs.local -RRType CName



