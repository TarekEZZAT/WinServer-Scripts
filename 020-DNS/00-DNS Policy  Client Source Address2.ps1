#20 - DNS Policy  Client Source Address (Server)

#Reminder
Get-Command -Module DnsServer -Name *policy*

Add-DnsServerPrimaryZone -Name "clients.local" -ReplicationScope Domain

Add-DnsServerClientSubNet -name subnet_64 IPv4Subnet "192.168.10.64/26"
Add-DnsServerClientSubNet -name subnet_64 IPv4Subnet "192.168.10.128/26"

Add-DnsServerZoneScope -ZoneName "clients.local" -Name "Scope-64"
Add-DnsServerZoneScope -ZoneName "clients.local" -Name "Scope-128"

Add-DnsServerResourceRecord 
		-ZoneName "clients.local" 
		-A 
		-Name cli-srv 
		-IPv4Address "22.22.22.22"
		-ZoneScope "Scope-64"

Add-DnsServerResourceRecord 
		-ZoneName "clients.local" 
		-A 
		-Name cli-srv 
		-IPv4Address "33.33.33.33"
		-ZoneScope "Scope-128"
		
		
Add-DnsServerQueryResolutionPolicy 
		-Name "Scope-64-Policy"
		-Action ALLOW #(ALLOW|DENY|IGNORE)
		-ClientSubnet "EQ,subnet_64"
		-ZoneScope"Scope_64,1"
		-ZoneName "client.local"
		
Add-DnsServerQueryResolutionPolicy 
		-Name "Scope-128-Policy"
		-Action ALLOW #(ALLOW|DENY|IGNORE)
		-ClientSubnet "EQ,subnet_128"
		-ZoneScope"Scope_128,1"
		-ZoneName "client.local"

