# 04-Set DHCP Server

# Get Env Settings

##$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
. $dir"\00-EnvNetSettings.PS1"


## Install the bits on the server for DHCP
# Install DHCP Server


Install-WindowsFeature 'DHCP' -IncludeAllSubFeature -IncludeManagementTools

## Authorize the DHCP server in Active Directory
#Add-DhcpServerInDC -DnsName $Env:COMPUTERNAME
#Remove-DhcpServerInDC -DnsName $DnsServerFQDN -IPAddress $ServerIpAddress
Add-DhcpServerInDC -DnsName $DnsServerFQDN -IPAddress $ServerIpAddress


## Create an IPv4 DHCP scope
Add-DhcpServerv4Scope -EndRange $EndRange -Name $Serverv4ScopeName -StartRange $StartRange -SubnetMask $SubnetMask -LeaseDuration $LeaseDuration


## Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DnsDomain $DomainName -DnsServer $ServerIpAddress

Restart-service dhcpserver