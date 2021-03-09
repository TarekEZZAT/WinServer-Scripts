# Install Domain Controller

## Set a static IP
$ipaddress = '192.168.10.3'
$ipprefix = '24'
$ipgw = '192.168.10.254'
$ipdns = '192.168.10.3'
$ipif = (Get-NetAdapter).ifIndex

#Remove-NetIPAddress -IPAddress $ipaddress
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix -InterfaceIndex $ipif

## Set the NIC to use itself as the DNS server 
#  this is going to be a domain controller
Set-DnsClientServerAddress -InterfaceIndex $ipif -ServerAddresses $ipdns

## Rename the server and restart it to commit the change
$newname = 'TEST-DC'
Rename-Computer -NewName $newname -force
Restart-Computer -Force

##+++++++++++++++++++++++++++++++

## Install the bits for Active Directory Domain Services



Install-WindowsFeature 'AD-Domain-Services' `
	-IncludeAllSubFeature `
	-IncludeManagementTools

# Create New Forest, add Domain Controller
$domainname = 'labs.local'
$netbiosName = 'WSRV3-DC'
$DatabasePath='C:\HYPER-V\VM';
$ForestMode='Win2012';
Import-Module ADDSDeployment

$ad_params = @{
 CreateDnsDelegation=$false;
 DatabasePath=$DatabasePath;
 DomainMode=DomainMode;
 DomainName=$domainname;
 DomainNetbiosName=$netbiosName;
 ForestMode=ForestMode;
 InstallDns=$true;
 NoRebootOnCompletion=$false;
 Force=$true;
 SafeModeAdministratorPassword=(ConvertTo-SecureString 'hyper/1' -AsPlainText -Force);
}

Install-ADDSForest @ad_params

##+++++++++++++++++++++++++++++++

## Install the bits on the server for DHCP
# Install DHCP Server

$DnsDomain = "labs.local"
$DnsName "WSRV3-DC.labs.local"
$ServerIPAddress = "192.168.10.8"
$ServerV4ScopeName = 'Test Scope'
$StartRange = '192.168.10.100' 
$EndRange ='192.168.10.250'
$SubnetMask ='255.255.255.0'
$LeaseDuration = '1.00:00:00'


Install-WindowsFeature 'DHCP' -IncludeAllSubFeature -IncludeManagementTools

## Authorize the DHCP server in Active Directory
Add-DhcpServerInDC -DnsName $-DnsName -IPAddress $ServerIPAddress

## Create an IPv4 DHCP scope
Add-DhcpServerV4Scope 
	-Name $Serverv4ScopeName 
	-StartRange $StartRange 
	-EndRange EndRange 
	-SubnetMask SubnetMask
	-LeaseDuration $LeaseDuration

## Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DnsDomain $DnsDomain -DnsServer $ServerIPAddress

Restart-service dhcpserver
