### 01-Set Net Environnement


# Get Env Settings

#$dir = pwd | Select-Object | %{$_.ProviderPath}
$dir = 'C:\Users\Administrateur\Desktop\SCRIPTS'
. $dir"\00-EnvNetSettings.PS1"

#++++++++++++++++++++++++++++++++++++

Remove-NetIPAddress $OldServerIPAddress
New-NetIPAddress -InterfaceIndex $NetAdapterInterfaceIndex -IPAddress $ServerIPAddress  -PrefixLength $NetIPPrefix

#Remove-NetRoute -InterfaceNetAdapterInterfaceIndex $NetAdapterInterfaceNetAdapterInterfaceIndex -DestinationPrefix 0.0.0.0/0


<#
$OldServerIPAddress
$ServerIPAddress 
$NetIPPrefix  
$NetAdapterInterfaceIndex  
$ServerIPGateway
#>


#+++++
#variables
<#
$ServerIPAddress='1.2.3.4'
$NetAdapterInterfaceIndex = get-netServerIPAddress | where-object {$_.ServerIPAddress -eq $ServerIPAddress} | select -ExpandProperty InterfaceNetAdapterInterfaceIndex
$Log = 'c:\windows\gatewaychange.log'
$gateway = get-netroute -DestinationPrefix $NetIPPrefix | select -ExpandProperty NextHop
$oldroute = '1.1.1.1'
$destination = '0.0.0.0/0'
#>
#Start Changing the Gateway if needed

$newroute = $ServerIPGateway

Function Swap-Gateway() {

remove-netroute -InterfaceIndex $NetAdapterInterfaceIndex -NextHop $oldroute -confirm:$false
new-netroute -InterfaceIndex $NetAdapterInterfaceIndex -NextHop $newroute -destinationprefix $destination -confirm:$false
sleep 3

}

if ($gateway -ne $oldroute) {
Write-Warning -Message "Gateway is set to $gateway and will be changed to $newroute"
#Swap-Gateway | Out-file $Log -Append
Swap-Gateway
}
elseif ($gateway -eq $newroute) {
Write-Warning -Message "Gateway is already set to $newroute and needs no change"
}

#+++++


## Set the NIC to use itself as the DNS server 
#  this is going to be a domain controller
Set-DnsClientServerAddress -InterfaceIndex $NetAdapterInterfaceIndex -ServerAddresses $PrincipalDNSIP

## Rename the server and restart it to commit the change
Rename-Computer -NewName $ComputerNewName -force
Restart-Computer -Force
