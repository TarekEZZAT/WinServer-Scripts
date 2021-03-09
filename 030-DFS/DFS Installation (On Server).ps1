# DFS Installation (On Server)

# Adapt computers names

# Get-WindowsFeature -ComputerName WSRV1-DC FS-DFS*
#Get-WindowsFeature FS-DFS*
Install-WoindowsFeature FS-DFS-NameSpace -IncludeManagementTools
#Invoke-Command -ComputerName <SRV2>,<SRV3> -command {Install-WoindowsFeature FS-DFS-Replication}
Get-WindowsFeature FS-DFS*
#Get-WindowsFeature -ComputerName <SRV2> FS-DFS*
#Get-WindowsFeature -ComputerName <SRV3> FS-DFS*



