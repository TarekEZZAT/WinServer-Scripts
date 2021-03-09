Get-NetAdapter
Get-NetIPConfiguration -Detailed
$netAdapter = Get-NetAdapter -Name Ethernet
$netAdapter
# Get-Help Set-NetIPAddress
Remove-NetIPAddress 192.168.10.5 

New-NetIPAddress -InterfaceIndex 4 -IPAddress 192.168.10.2 -PrefixLength 24 
ipconfig /all

Rename-Computer -NewName WSRV1-DC -Force -Restart