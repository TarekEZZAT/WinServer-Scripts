# 00-EnvNetSettings

#$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
## Set a static IP

$OldServerIPAddress = (Get-NetIPConfiguration).IPv4Address.IPAddress

$ServerIPAddress = '192.168.10.8'
$NetIPPrefix = '24'
$ServerIPGateway = '192.168.10.254'
$PrincipalDNSIP = '192.168.10.8'
$NetAdapterInterfaceIndex = (Get-NetAdapter).ifIndex
$OldRoute=(Get-NetIPConfiguration).IPv4DefaultGateway.NextHop
$destination = '0.0.0.0/0'
$ComputerNewName = 'WSRV3-DC'

# DC & AD

$ADRestorePassword = 'hyper/1'


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

$dir = 'Hello!'
$dir

#++++++++++++++++++++++++++++++++++++
