# Round Robin & DNS Policies

# setup the follow scopes on yours DNS server

Add-DnsServerResourceRecordA -IPv4Address 192.168.10.101 -Name training.com -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.102 -Name training.com -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.103 -Name training.com -ZoneName labs.local -CreatePtr

Add-DnsServerResourceRecordA -IPv4Address 192.168.10.101 -Name training -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.102 -Name training -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.103 -Name training -ZoneName labs.local -CreatePtr




Add-DnsServerZoneScope -ZoneName "labs.local" -Name "testing"
Add-DnsServerZoneScope -ZoneName "labs.local" -Name "programing"
Add-DnsServerZoneScope -ZoneName "labs.local" -Name "design"


# Create DNS policies that distribute the incoming queries
# across these scopes 
# 50% of queries with the IP address for testing
# 50% of queries with the IP address for programing
# 50% of queries with the IP address for design

Add-DnsServerQueryResolutionPolicy 
	-Name "DevPolicy" 
	-Action ALLOW 
	-ZoneScope "testing,2;programing,1;design,1" 
	-ZoneName "training.com"


++++++++++++++++++++++++++++++

Get-DnsClientCache
Get-DnsServerCache

Get-DnsClientCache
Add-DnsServerForwarder 8.8.4.4

Get-DnsServerRootHint
Add-DnsServerRootHint server1.opendns.com 208.67.222.222


Remove-DnsServerForwarder 8.8.8.8

Add-DnsServerResourceRecordA -IPv4Address 192.168.10.101 -Name training -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.102 -Name training -ZoneName labs.local -CreatePtr
Add-DnsServerResourceRecordA -IPv4Address 192.168.10.103 -Name training -ZoneName labs.local -CreatePtr

Add-DnsServerZoneScope -ZoneName "labs.local" -Name "testing"
Add-DnsServerZoneScope -ZoneName "labs.local" -Name "programing"
Add-DnsServerZoneScope -ZoneName "labs.local" -Name "design"



Add-DnsServerQueryResolutionPolicy 
	-Name "DevPolicy2" 
	-Action ALLOW 
	-ZoneScope "testing,2;programing,1;design,1" 
	-ZoneName "training"

Remove-DnsServerQueryResolutionPolicy -Name "DevPolicy2" 
	-Action ALLOW 
	-ZoneScope "testing,2;programing,1;design,1" 
	-ZoneName "training"
	
	

