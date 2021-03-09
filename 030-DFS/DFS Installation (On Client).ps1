# DFS Installation (On Client)

# Adapt computers names

Get-WindowsFeature -ComputerName <DC> FS-DFS*
Invoke-Command -ComputerName <DC> -command {Install-WoindowsFeature FS-DFS-NameSpace -IncludeManagementTools}
Invoke-Command -ComputerName <SRV2>,<SRV3> -command {Install-WoindowsFeature FS-DFS-Replication}
Get-WindowsFeature -ComputerName <SRV2> FS-DFS*
Get-WindowsFeature -ComputerName <SRV3> FS-DFS*



