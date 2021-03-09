
. $dir"\EnvNetSettings.PS1"
Remove-NetIPAddress $OldServerIPAddress
New-NetIPAddress -IPAddress $ServerIPAddress -PrefixLength $NetIPPrefix -InterfaceIndex $NetAdapterInterfaceIndex -DefaultGateway $ServerIPGateway

## Set the NIC to use itself as the DNS server 
#  this is going to be a domain controller
Set-DnsClientServerAddress -InterfaceIndex $NetAdapterInterfaceIndex -ServerAddresses $PrincipalDNSIP

## Rename the server and restart it to commit the change
Rename-Computer -NewName $ComputerNewName -force
Restart-Computer -Force

##+++++++++++++++++++++++++++++++


## Install the bits for Active Directory Domain Services

Import-Module ADDSDeployment
Install-WindowsFeature 'AD-Domain-Services' `
	-IncludeAllSubFeature `
	-IncludeManagementTools


$ActiveDirectoryParams = @{
 CreateDnsDelegation=$false;
 DatabasePath=$DatabasePath;
 #DomainMode=$DomainMode;
 DomainName=$DomainName;
 DomainNetBiosName=$NetBiosName;
 #ForestMode=$ForestMode;
 InstallDns=$true;
 NoRebootOnCompletion=$false;
 Force=$true;
 SafeModeAdministratorPassword=(ConvertTo-SecureString 'hyper/1' -AsPlainText -Force);
}

Install-ADDSForest @ActiveDirectoryParams


##+++++++++++++++++++++++++++++++


## Install the bits on the server for DHCP
# Install DHCP Server


Install-WindowsFeature 'DHCP' -IncludeAllSubFeature -IncludeManagementTools

## Authorize the DHCP server in Active Directory
Add-DhcpServerInDC -DnsServerFQDN $DnsServerFQDN -ServerIPAddress $ServerIpAddress
Remove-DhcpServerInDC -DnsServerFQDN $DnsServerFQDN -ServerIPAddress $ServerIpAddress


## Create an IPv4 DHCP scope
Add-DhcpServerV4Scope `
	-Name $Serverv4ScopeName ` 
	-StartRange $StartRange  `
	-EndRange $EndRange  `
	-SubnetMask $SubnetMask `
	-LeaseDuration $LeaseDuration

## Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DomainName $DomainName -DnsServer $ServerIpAddress

Restart-service dhcpserver
