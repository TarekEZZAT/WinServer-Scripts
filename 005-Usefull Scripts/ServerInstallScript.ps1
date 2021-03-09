### Domain Controller Environment

## Install Domain Controller

## Set a static IP
$OldServerIPAddress = $env:HostIP = ((
    Get-NetIPConfiguration |
    Where-Object {
        $_.IPv4DefaultGateway -ne $null -and
        $_.NetAdapter.Status -ne "Disconnected"
    }
).IPv4Address).IPAddress



$ServerIPAddress = '192.168.10.8'
$NetIPPrefix = '24'
$ServerIPGateway = '192.168.10.254'
$PrincipalDNSIP = '192.168.10.8'
$NetAdapterInterfaceIndex = (Get-NetAdapter).ifIndex
$ComputerNewName = 'WSRV3-DC'

#++

# Forest
$DomainName = 'star.local'
$DomainMode = 'Win2012'
$NetBiosName = 'WSRV3-DC'
$DatabasePath='C:\HYPER-V\VM';
$ForestMode='Win2012';

#++

# DHCP

#$DomainName = "star.local"
$DnsServerFQDN ="WSRV3-DC.star.local"
#$ServerIpAddress = "192.168.10.8"
$ServerV4ScopeName = 'Test Scope'
$StartRange = '192.168.10.100' 
$EndRange ='192.168.10.250'
$SubnetMask ='255.255.255.0'
$LeaseDuration = '1.00:00:00'



#+++++++++++++++++++++++++++++++++++++

### 01-Set Net Environnement


# Get Env Settings

#$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
. $dir"\EnvNetSettings.PS1"

#++++++++++++++++++++++++++++++++++++

Remove-NetIPAddress $OldServerIPAddress
New-NetIPAddress $ServerIPAddress `
    -PrefixLength $NetIPPrefix  `
    -InterfaceIndex $NetAdapterInterfaceIndex ` 
    # -DefaultGateway $ServerIPGateway



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
